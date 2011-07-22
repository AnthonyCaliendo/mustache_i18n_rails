require 'helper'

describe Mustache::I18n::Javascript::Tags do

  before do
    @app = mock 'app'
    @metal = Mustache::I18n::Javascript::LocalizedMessages.new @app
    @metal.stub! :rails_root => '/tmp'
  end

  it 'skips urls which do not match' do
    @app.should_receive(:call)
  
    @metal.call 'PATH_INFO' => '/javascripts/cache/not-locales/en/pies/show.js'
  end

  context 'with relevant url' do
    before do
      @app.should_not_receive(:call)
      @result = @metal.call 'PATH_INFO' => '/javascripts/cache/locales/en/pies/show.js'
      # stubbing/mocking doesn't work as expected, so assert the tranlation failed message is returned
      @javascript_file_contents = "        Mustache = Mustache || {};\n        Mustache.I18n = Mustache.I18n || {};\n        Mustache.I18n.messages = {\"pies.show.translation missing: en, javascripts, pies, show\":null};\n"
    end

    it 'returns response with javascript file' do
      @result.first.should == 200
      @result.second['Content-Type'].should == 'text/javascript'
      @result.third.should == @javascript_file_contents
    end

    it 'writes file into rails_root directory' do
      File.exists?('/tmp/public/javascripts/cache/locales/en/pies/show.js').should be_true
      File.read('/tmp/public/javascripts/cache/locales/en/pies/show.js').to_s.should == @javascript_file_contents
    end
  end

end