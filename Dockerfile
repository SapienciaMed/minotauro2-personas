FROM --platform=linux/amd64 ruby:2.5-slim

# ─────────────────────────────────────────────────────────────────
# USUARIO
# ─────────────────────────────────────────────────────────────────
RUN useradd -m -s /bin/bash sapiencia && \
    echo "sapiencia ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /usr/share/man/man1

# ─────────────────────────────────────────────────────────────────
# FIX BUSTER EOL — redirigir a archive.debian.org
# ─────────────────────────────────────────────────────────────────
RUN set -eux; \
    sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list; \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list; \
    sed -i '/buster-updates/d' /etc/apt/sources.list; \
    printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99no-check-valid

# ─────────────────────────────────────────────────────────────────
# DEPENDENCIAS DEL SISTEMA
# ─────────────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libaio1 \
    libaio-dev \
    freetds-bin \
    freetds-dev \
    unixodbc-dev \
    build-essential \
    ruby-dev \
    zlib1g-dev \
    libxml2-dev \
    libsqlite3-dev \
    libxslt1-dev \
    libgmp-dev \
    pkg-config \
    nano \
    curl \
    libxrender1 \
    libfontconfig1 \
    libxext6 \
    libx11-6 \
    libssl-dev \
    libjpeg62-turbo \
    libpng-dev \
    xvfb \
    imagemagick \
    pdftk \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# ─────────────────────────────────────────────────────────────────
# NODE.JS 16 + YARN — usando binarios directos (sin nodesource)
# ─────────────────────────────────────────────────────────────────
RUN curl -fsSL https://nodejs.org/dist/v16.20.2/node-v16.20.2-linux-x64.tar.gz \
    | tar -xz -C /usr/local --strip-components=1 \
    && node --version \
    && npm --version \
    && npm install -g yarn \
    && yarn --version

# ─────────────────────────────────────────────────────────────────
# ORACLE INSTANT CLIENT 19c
# ─────────────────────────────────────────────────────────────────
RUN mkdir -p /home/oracle
WORKDIR /home/oracle

COPY instantclient-basic-linux.x64-19.3.0.0.0dbru.zip /home/oracle/
COPY instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip /home/oracle/
COPY instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip /home/oracle/

RUN unzip -qo instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    unzip -qo instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip && \
    unzip -qo instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip && \
    rm -f *.zip && \
    chmod -R 755 /home/oracle/instantclient_19_3

WORKDIR /home/oracle/instantclient_19_3

RUN ln -sf libclntsh.so.19.1 libclntsh.so && \
    ln -sf libocci.so.19.1   libocci.so

# Variables de entorno Oracle 19c
ENV ORACLE_HOME=/home/oracle/instantclient_19_3
ENV LD_LIBRARY_PATH=/home/oracle/instantclient_19_3
ENV DYLD_LIBRARY_PATH=/home/oracle/instantclient_19_3
ENV OCI_DIR=/home/oracle/instantclient_19_3
ENV PATH="/home/oracle/instantclient_19_3:${PATH}"

# ─────────────────────────────────────────────────────────────────
# CONFIGURACIÓN USUARIO SAPIENCIA
# ─────────────────────────────────────────────────────────────────
USER sapiencia
WORKDIR /home/sapiencia/app

ENV ORACLE_HOME=/home/oracle/instantclient_19_3
ENV LD_LIBRARY_PATH=/home/oracle/instantclient_19_3

# Bundler
RUN gem install bundler:2.3.21

# Gemas Oracle y dependencias nativas
RUN gem install tiny_tds  -v 2.1.2 && \
    gem install ruby-oci8           && \
    gem install racc      -v 1.5.2  && \
    gem install pkg-config -v "~> 1.1"

# ─────────────────────────────────────────────────────────────────
# GEMAS DEL PROYECTO
# ─────────────────────────────────────────────────────────────────
COPY --chown=sapiencia:sapiencia Gemfile Gemfile.lock ./
RUN bundle install -j4

# ─────────────────────────────────────────────────────────────────
# PATCH DEVISE 4.0.0 — fix sintaxis Ruby 2.5
# ─────────────────────────────────────────────────────────────────
RUN sed -i 's/prepend_before_action only: \[:create, :destroy\] { request.env\["devise.skip_timeout"\] = true }/prepend_before_action only: [:create, :destroy] do\n    request.env["devise.skip_timeout"] = true\n  end/' \
    /usr/local/bundle/gems/devise-4.0.0/app/controllers/devise/sessions_controller.rb


# ─────────────────────────────────────────────────────────────────
# APLICACIÓN
# ─────────────────────────────────────────────────────────────────
COPY --chown=sapiencia:sapiencia . .

COPY --chown=sapiencia:sapiencia entrypoint.sh /home/sapiencia/app/entrypoint.sh
RUN chmod +x /home/sapiencia/app/entrypoint.sh

ENTRYPOINT ["bash", "/home/sapiencia/app/entrypoint.sh"]
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]