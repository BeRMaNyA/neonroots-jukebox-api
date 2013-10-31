require 'spec_helper'

describe Song do
  before do
    Song.delete_all
  end

  it "must have a title" do
    should have(1).error_on(:title)
  end

  it "must have an album" do
    should have(1).error_on(:album)
  end

  it "must have an artist" do
    should have(1).error_on(:artist)
  end

  it "must have a price" do
    should have(1).error_on(:price_in_cents)
  end

  it "should not be duplicated" do
    song      = FactoryGirl.create(:song)
    new_song  = Song.new(title: song.title, artist: song.artist, album: song.album)
    new_song2 = Song.new(title: song.title, artist: song.artist, album: "NeonRoots Collection")
    new_song3 = Song.new(title: song.title, artist: "NeonRoots", album: song.album)

    new_song.save
    new_song.should have(1).error_on(:title)

    new_song2.save
    new_song2.should_not have(1).error_on(:title)

    new_song3.save
    new_song2.should_not have(1).error_on(:title)
  end

  describe "#price" do
    let(:song) { FactoryGirl.create(:song, price_in_cents: 150) }

    it "returns price in dollars" do
      song.price.should == 1.50
    end
  end

  describe ".on_sale" do
    it "returns songs priced $1 or less" do
      FactoryGirl.create(:song, price_in_cents: 300)
      FactoryGirl.create(:song, price_in_cents: 150)
      FactoryGirl.create(:song, price_in_cents: 100)
      FactoryGirl.create(:song, price_in_cents: 80)

      Song.on_sale.size.should be 2
    end
  end
end
