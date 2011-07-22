class Mustache
  # Provides localization and internationalization support for mustache.
  module I18n
    VERSION = '0.1.0'

    def self.included(base)
      base.send :include, Tags
    end

    class << self

      # The root key to be used for all javascript/mustache translations.
      def translation_root_key
        @@translation_root_key ||= 'javascripts'
      end

      def translation_root_key=(value)
        @@translation_root_key = value
      end

      def javascript_namespace
        @@javascript_namespace ||= 'Mustache'
      end

      def javascript_namespace=(value)
        @@javascript_namespace = value
      end

    end
  end
end