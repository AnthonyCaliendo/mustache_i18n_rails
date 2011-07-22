require 'helper'

describe Mustache::I18n do
  before :all do
    Mustache.template_path = File.join(File.dirname(__FILE__), 'templates')
  end

  it 'renders simple key correctly' do
    I18n.should_receive(:translate).with('javascripts.pies.show.pie_flavor', {}).and_return 'success'
    Mustache.render_file('simple_key', {}).should == 'success'
  end

  it 'renders key with arguments correctly' do
    I18n.should_receive(:translate).with('javascripts.pies.show.remaining_pieces', {'count' => 7}).and_return 'success'
    Mustache.render_file('key_with_arguments', {:pie_remaining_pieces => 7}).should == 'success'
  end

end