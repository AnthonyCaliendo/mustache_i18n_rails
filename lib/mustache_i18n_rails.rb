require File.join(File.dirname(__FILE__), 'mustache/i18n')
require File.join(File.dirname(__FILE__), 'mustache/i18n/tags')
require File.join(File.dirname(__FILE__), 'mustache/i18n/action_view_helper')
require File.join(File.dirname(__FILE__), 'mustache/i18n/javascript/cache_writer')
require File.join(File.dirname(__FILE__), 'mustache/i18n/javascript/localized_messages')
require File.join(File.dirname(__FILE__), 'mustache/i18n/javascript/tags')


Mustache.send :include, Mustache::I18n
ActionView::Base.send(:include, Mustache::I18n::ActionViewHelper) if defined?(ActionView::Base)
if defined?(ActionController::Dispatcher)
  ActionController::Dispatcher.middleware.
    use(Mustache::I18n::Javascript::LocalizedMessages).
    use(Mustache::I18n::Javascript::Tags)
end