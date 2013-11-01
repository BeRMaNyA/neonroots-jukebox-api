require 'spec_helper'

describe 'Songs API' do
  context "failed request" do
    let(:url) { "/songs.json" }
    subject { JSON.parse(last_response.body)['errors'] }

    context "title is not provided" do
      it "responds with an error" do
        post url, { album: 'test', artist: 'test', price_in_cents: '50' }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials('berna')
        should have_key('title')
      end
    end

    context "name is duplicated" do
      it "respond with an error" do
        song = FactoryGirl.create(:song)
        post url, { title: song.title, album: song.album, artist: song.artist, price: 100 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials('berna')
        should have_key('title')
      end
    end
  end

  context "successful request" do
    let(:url) { "/songs.json" }
    subject { JSON.parse(last_response.body) }

    it "returns a song record" do
      post url, { title: "Awesome Song", artist: "Berna", album: "Top Hits", price: 100 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials('berna')
      song = Song.last

      subject.should == { "id" => song.id, "title" => song.title, "artist" => song.artist, "album" => song.album, "price" => song.price }
    end

    context "returns a list of songs in the server" do
      before do
        100.times.each do
          FactoryGirl.create :song
        end
        FactoryGirl.create :bar
      end

      it "should paginate the first 50 songs" do
        get url, { limit: 50 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(Bar.last.token)
        subject["pagination"].should == { "total"=>100, "total_pages"=>2, "current_page"=>1 }
      end

      it "should paginate the second 50 songs" do
        get url, { limit: 50, page: 2 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(Bar.last.token)
        subject["pagination"].should == { "total"=>100, "total_pages"=>2, "current_page"=>2 }
      end
    end

    context "returns a list of songs on sale" do
      before do
        100.times.each do
          FactoryGirl.create :song, price_in_cents: 100
        end
      end

      let(:url) { "/songs/on_sale.json" }

      it "should paginate the first 50 songs on sale" do
        get url, { limit: 50 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials("berna")
        subject["pagination"].should == { "total"=>100, "total_pages"=>2, "current_page"=>1 }
      end

      it "should paginate the second 50 songs on sale" do
        get url, { page: 2, limit: 50 }, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials("berna")
        subject["pagination"].should == { "total"=>100, "total_pages"=>2, "current_page"=>2 }
      end
    end
  end
end
