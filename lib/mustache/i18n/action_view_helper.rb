module Mustache::I18n::ActionViewHelper

  def include_i18n_javascripts
    relative_path = File.dirname(@template.template.relative_path.gsub('app/views/', ''))
    javascript_include_tag 'cache/mustache_i18n', "cache/locales/#{I18n.locale}/#{relative_path}/#{controller.action_name}.js"
  end

end