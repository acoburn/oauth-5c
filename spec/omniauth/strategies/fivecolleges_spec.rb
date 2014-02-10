require 'spec_helper'

describe OmniAuth::Strategies::FiveColleges do
  subject do
    OmniAuth::Strategies::FiveColleges.new({})
  end

  context "client options" do
    it 'should have correct name' do
      subject.options.name.should eq("fivecolleges")
    end

    it 'should have correct site' do
      subject.options.client_options.site.should eq('https://www.ats.amherst.edu')
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_path.should eq('/oauth/authorize')
    end
  end
end
