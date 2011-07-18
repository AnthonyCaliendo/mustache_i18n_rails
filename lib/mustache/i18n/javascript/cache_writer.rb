# Writes file contents to the rails public directory,
# and then returns a metal response with that content.
#
# This is best with nginx, etc. fronting the _javascript/cache_ files; otherwise,
# the file will be rewritten every time!
module Mustache::I18n::Javascript
  class CacheWriter

    protected
    def rails_root
      RAILS_ROOT
    end

    def cached_javascript(filename, &content_block)
      full_path = File.join(rails_root, 'public', filename)
      contents = yield

      FileUtils.mkdir_p File.dirname(full_path)
      File.open(full_path, 'w') do |f|
        f.write contents
      end

      [ 200, {'Content-Type' => 'text/javascript'}, contents ]
    end

  end
end