require 'helper'

describe Mustache::I18n::Javascript::Tags do

  before do
    @app = mock 'app'
    @metal = Mustache::I18n::Javascript::Tags.new @app
    @metal.stub! :rails_root => '/tmp'
  end

  it 'skips urls which do not match' do
    @app.should_receive(:call)

    @metal.call 'PATH_INFO' => '/javascripts/cache/not_mustache_i18n.js'
  end

  context 'with relevant url' do
    before :all do
      @@javascript_file_contents = read_javascript 'mustache_i18n.js'
    end

    before do
      @app.should_not_receive(:call)
      @result = @metal.call 'PATH_INFO' => '/javascripts/cache/mustache_i18n.js'
    end

    it 'returns response with javascript file' do
      @result.first.should == 200
      @result.second['Content-Type'].should == 'text/javascript'
      @result.third.should == @@javascript_file_contents
    end

    it 'writes file into rails_root directory' do
      File.exists?('/tmp/public/javascripts/cache/mustache_i18n.js').should be_true
      File.read('/tmp/public/javascripts/cache/mustache_i18n.js').to_s.should == @@javascript_file_contents
    end
  end

end