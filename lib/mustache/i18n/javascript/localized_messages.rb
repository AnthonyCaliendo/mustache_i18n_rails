require 'json'

# Provides translations (localized text) to javascript.
class Mustache::I18n::Javascript::LocalizedMessages < Mustache::I18n::Javascript::CacheWriter

  PATH = /\/javascripts\/cache\/locales\/(\w{2,5})\/(.*?)\.js/

  def initialize(app)
    @app = app
  end

  def call(env)
    locale_and_root_key = parse_path env['PATH_INFO']
    return @app.call(env) if locale_and_root_key.blank?

    cached_javascript env['PATH_INFO'] do
      root_key      = locale_and_root_key.last
      translations  = flatten_translations I18n.translate(root_key, :locale => locale_and_root_key.first, :scope => Mustache::I18n.translation_root_key), root_key

      <<-JS
        Mustache = Mustache || {};
        Mustache.I18n = Mustache.I18n || {};
        Mustache.I18n.messages = #{translations.to_json};
      JS
    end
  end

  private
  def parse_path(path)
    matched_path = PATH.match(path)
    return nil if matched_path.blank? || (captures = matched_path.captures).blank?

    [ captures[0], captures[1].gsub("\/", '.') ]
  end

  # recursively flatten nested translations into a single, long key
  def flatten_translations(hash, prefix = '')
    hash.inject({}) do |sum, entry|
      key, value = entry
      key        = prefix.empty? ? key.to_s : "#{prefix}.#{key.to_s}"

      value.kind_of?(Hash) ? sum.merge!(flatten_translations value, key) : (sum[key] = value)
      sum
    end
  end

end