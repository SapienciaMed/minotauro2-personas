Paperclip::Attachment.default_options[:url] = '/system/:attachment/:id/:style/:filename'
Paperclip::Attachment.default_options[:path] = ':rails_root/public:url'

#Paperclip::Attachment.default_options[:url] = '/system/:attachment/:id/:style/:filename'
#Paperclip::Attachment.default_options[:path] = "/Datos/#{ENV['CARPETA_IMAGENES']}/public:url"

Paperclip.options[:content_type_mappings] = {
    sal: %w(text/plain)
}