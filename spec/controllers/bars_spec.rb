require 'spec_helper'

describe 'Bars API' do
  context "failed request" do
    let(:url) { '/bars.json' }
    subject { JSON.parse(last_response.body)['errors'] }

    context "name is not provided" do
      it "responds with an error" do
        post url
        should have_key('name')
      end
    end

    context "name is duplicated" do
      it "respond with an error" do
        bar = FactoryGirl.create(:bar)
        post url, { name: bar.name }
        should have_key('name_downcased')
      end
    end
  end

  context "successful request" do
    let(:url) { '/bars.json' }
    subject { JSON.parse(last_response.body) }

    it "returns a bar record" do
      post url, { name: "Awesome Bar" }
      bar = Bar.last

      subject.should == { "id" => bar.id, "name" => bar.name, "token" => bar.token }
    end

    context "buys a song" do
      before do
        FactoryGirl.create(:bar)
        FactoryGirl.create(:song)
      end

      it "returns a song record" do
        bar  = Bar.last
        song = Song.last

        post "/bars/#{bar.id}/songs.json", { song_id: song.id }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(Bar.last.token)
        subject.should == { "id" => song.id, "title" => song.title, "artist" => song.artist, "album" => song.album, "price" => song.price }
      end
    end
  end
end
