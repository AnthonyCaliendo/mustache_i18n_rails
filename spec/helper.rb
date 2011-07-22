require 'spec'
require 'mustache'
require 'active_support'
require 'json'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'mustache_i18n_rails'

def read_javascript(filename)
  File.read(File.join(File.dirname(__FILE__), "javascripts/#{filename}")).to_s
end