module Mustache::I18n::ActionViewHelper

  def include_i18n_javascripts(*javascripts)
    relative_path = File.dirname(@template.template.relative_path.gsub('app/views/', ''))

    javascripts.unshift "#{relative_path}/#{controller.action_name}.js"
    javascripts = javascripts.map {|js| "cache/locales/#{I18n.locale}/#{js}" }
    javascripts.unshift 'cache/mustache_i18n'

    javascript_include_tag *javascripts
  end

end