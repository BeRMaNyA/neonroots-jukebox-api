require 'spec_helper'

describe 'Bars API' do
  context "failed request" do
    subject { JSON.parse(last_response.body)['errors'] }

    context "name is not provided" do
      it "responds with an error" do
        post '/bars'
        should have_key('name')
      end
    end

    context "name is duplicated" do
      it "respond with an error" do
        bar = FactoryGirl.create(:bar)
        post "/bars", { name: bar.name }
        should have_key('name_downcased')
      end
    end
  end

  context "successful request" do
    subject { JSON.parse(last_response.body) }

    it "returns a bar record" do
      post "/bars", { name: "Awesome Bar" }
      bar = Bar.last

      subject['id'].should    == bar.id
      subject['name'].should  == bar.name
      subject['token'].should == bar.token
    end
  end
end
