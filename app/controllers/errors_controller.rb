class ErrorsController < ApplicationController
  layout :determine_layout
  def not_found
    begin
      exception = request.env['action_dispatch.exception']
      message = exception.message.to_s rescue nil
      source_extract = exception.source_extract.join("\n") rescue nil
      backtrace = exception.backtrace[0..9].join("\n") rescue nil
      SlackNotifyJob.perform_in(5,message, source_extract, backtrace, current_user, 404)
    ensure
      render status: 404
    end
  end

  def internal_server_error
    begin
      exception = request.env['action_dispatch.exception']
      message = exception.message.to_s rescue nil
      source_extract = exception.source_extract.join("\n") rescue nil
      backtrace = exception.backtrace[0..9].join("\n") rescue nil
      SlackNotifyJob.perform_in(5,message, source_extract, backtrace, current_user, 500)
    ensure
      render status: 500
    end
  end

  def blank_page
    begin
      exception = request.env['action_dispatch.exception']
      message = exception.message.to_s rescue nil
      source_extract = exception.source_extract.join("\n") rescue nil
      backtrace = exception.backtrace[0..9].join("\n") rescue nil
      SlackNotifyJob.perform_in(5,message, source_extract, backtrace, current_user, 402)
    ensure
      render status: 402
    end
  end

  def error_404
    begin
      exception = request.env['action_dispatch.exception']
      message = exception.message.to_s rescue nil
      source_extract = exception.source_extract.join("\n") rescue nil
      backtrace = exception.backtrace[0..9].join("\n") rescue nil
      SlackNotifyJob.perform_in(5,message, source_extract, backtrace, current_user, 404)
    ensure
      render status: 404
    end
  end

  def error_505
    begin
      exception = request.env['action_dispatch.exception']
      message = exception.message.to_s rescue nil
      source_extract = exception.source_extract.join("\n") rescue nil
      backtrace = exception.backtrace[0..9].join("\n") rescue nil
      SlackNotifyJob.perform_in(5,message, source_extract, backtrace, current_user, 505)
    ensure
      render status: 505
    end
  end

  private

  def determine_layout
    "errors"
  end
end
