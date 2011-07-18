require 'spec'
require 'mustache'
require 'active_support'
require 'json'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'mustache_i18n_rails'