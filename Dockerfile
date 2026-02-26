# Usa Ruby 2.5 como imagen base en arquitectura x86-64
FROM --platform=linux/amd64 ruby:2.5-slim

# Crear el usuario 'sapiencia5' con home directory y shell bash
RUN useradd -m -s /bin/bash sapiencia5 && \
    echo "sapiencia5 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Crear directorio para que funcione pdftk
RUN mkdir -p /usr/share/man/man1

# Instalar dependencias del sistema (incluye ImageMagick)
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
    && rm -rf /var/lib/apt/lists/*


# Instalar Node.js y Yarn (requerido para Rails)
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install -y ngrok    

# Instalar pdftk-java (versión moderna mantenida por Debian)
RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && \
    apt-get install -y pdftk

# Crear directorio para Oracle Instant Client
RUN mkdir -p /home/oracle

# 🔹 Copiar el archivo de Oracle Instant Client desde la carpeta del proyecto
COPY instantclient_12_2.zip /home/oracle/

# Cambiar el directorio de trabajo a /opt/oracle
WORKDIR /home/oracle

# Descomprimir el archivo
RUN unzip -qo instantclient_12_2.zip && \
    rm -f instantclient_12_2.zip

# Cambiar el directorio de trabajo a la carpeta descomprimida
WORKDIR /home/oracle/instantclient_12_2

RUN chmod -R 777 /home/oracle/instantclient_12_2

# 🔹 Crear enlaces simbólicos necesarios
RUN ln -s libclntsh.so.12.1 libclntsh.so && \
    ln -s libocci.so.12.1 libocci.so

# 🔹 Configurar variables de entorno
ENV LD_LIBRARY_PATH=/home/oracle/instantclient_12_2:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/home/oracle/instantclient_12_2
ENV ORACLE_HOME=/home/oracle/instantclient_12_2
ENV OCI_DIR=/home/oracle/instantclient_12_2
ENV PATH="/home/oracle/instantclient_12_2:${PATH}"
RUN echo "source ~/.bashrc" >> /home/sapiencia5/.bash_profile

# Cambiar a usuario "sapiencia5"
USER sapiencia5
WORKDIR /home/sapiencia5/app

# Configurar variables de entorno en el entorno del usuario sapiencia5
ENV ORACLE_HOME=/home/oracle/instantclient_12_2
ENV LD_LIBRARY_PATH=/opt/home/instantclient_12_2:$LD_LIBRARY_PATH

# Instalar Bundler y gemas necesarias
RUN gem install bundler:2.3.21
RUN gem install tiny_tds -v 2.1.2
RUN gem install ruby-oci8
RUN gem install racc -v 1.5.2
RUN gem install pkg-config -v "~> 1.1"

# Copiar archivos de dependencias y código
COPY --chown=sapiencia5:sapiencia5 Gemfile Gemfile.lock ./
# 8. Instalar gemas
RUN bundle install

# 9. Copiar aplicación
COPY --chown=sapiencia5:sapiencia5 . .

# 10. Configurar entrypoint
COPY --chown=sapiencia5:sapiencia5 entrypoint.sh /home/sapiencia5/app/entrypoint.sh

# 11. Cambiar permisos del archivo entrypoint.sh
RUN chmod +x /home/sapiencia5/app/entrypoint.sh

# 12. Establecer entrypoint
ENTRYPOINT ["bash", "/home/sapiencia5/app/entrypoint.sh"]

# 13. Exponer puertos
EXPOSE 3000

# 14. Comando para iniciar Rails
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]