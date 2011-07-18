# Adds localization tags which can be used by mustache templates.
module Mustache::I18n::Tags

  def translate
    lambda do |comma_delimited_args|
      args   = comma_delimited_args.strip.split ','
      key    = args.shift
      params = args.empty? ? {} : JSON.parse(args.first).with_indifferent_access

      I18n.translate("#{Mustache::I18n.translation_root_key}.#{key}", params)
    end
  end

end