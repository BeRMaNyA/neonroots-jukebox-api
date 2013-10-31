require 'spec_helper'

describe 'Songs API' do
  context "failed request" do
    subject { JSON.parse(last_response.body)['errors'] }

    context "title, artist, album and price are not provided" do
      it "responds with an error" do
        post '/songs'
        should have_key('title')
        should have_key('artist')
        should have_key('album')
        should have_key('price_in_cents')
      end
    end

    context "name is duplicated" do
      it "respond with an error" do
        song = FactoryGirl.create(:song)
        post "/songs", { title: song.title, album: song.album, artist: song.artist, price: 100 }
        should have_key('title')
      end
    end
  end

  context "successful request" do
    subject { JSON.parse(last_response.body) }

    it "returns a song record" do
      post "/songs", { title: "Awesome Song", artist: "Berna", album: "Top Hits", price: 100 }
      song = Song.last

      subject['id'].should     == song.id
      subject['title'].should  == song.title
      subject['artist'].should == song.artist
      subject['album'].should  == song.album
      subject['price'].should  == song.price
    end

    context "returns a list of songs in the server" do
      before do
        Song.destroy_all
        100.times.each do
          song = FactoryGirl.create :song
        end
      end

      let(:url) { "/songs" }

      it "should paginate the first 50 songs" do
        get url
        subject.should have_key("pagination")
        subject["pagination"]["total"].should == 100
        subject["pagination"]["total_pages"].should == 2
        subject["pagination"]["current_page"].should == 1
        subject.should have_key("songs")
        subject["songs"].count.should eql(50)
      end

      it "should paginate the second 50 songs" do
        get url, { page: 2 }
        subject.should have_key("pagination")
        subject["pagination"]["total"].should == 100
        subject["pagination"]["total_pages"].should == 2
        subject["pagination"]["current_page"].should == 2
        subject.should have_key("songs")
        subject["songs"].count.should eql(50)
      end
    end

    context "returns a list of songs on sale" do
      before do
        Song.destroy_all
        100.times.each do
          song = FactoryGirl.create :song, price_in_cents: 100
        end
      end

      let(:url) { "/songs/on_sale" }

      it "should paginate the first 50 songs on sale" do
        get url
        subject.should have_key("pagination")
        subject["pagination"]["total"].should == 100
        subject["pagination"]["total_pages"].should == 2
        subject["pagination"]["current_page"].should == 1
        subject.should have_key("songs")
        subject["songs"].count.should eql(50)
      end

      it "should paginate the second 50 songs on sale" do
        get url, { page: 2 }
        subject.should have_key("pagination")
        subject["pagination"]["total"].should == 100
        subject["pagination"]["total_pages"].should == 2
        subject["pagination"]["current_page"].should == 2
        subject.should have_key("songs")
        subject["songs"].count.should eql(50)
      end
    end
  end
end
