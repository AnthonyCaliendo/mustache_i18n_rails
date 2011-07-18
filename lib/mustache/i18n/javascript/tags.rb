# Adds localization tags which can be used by mustache templates in javascript.
class Mustache::I18n::Javascript::Tags < Mustache::I18n::Javascript::CacheWriter

    PATH = /\/javascripts\/cache\/mustache_i18n.js/

    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) if PATH.match(env['PATH_INFO']).blank?

      cached_javascript env['PATH_INFO'] do
        File.read(File.join(File.dirname(__FILE__), 'mustache_i18n.js')).to_s
      end
    end

end