require 'spec_helper'

describe Song do
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
    new_song  = FactoryGirl.build(:song, title: song.title, artist: song.artist, album: song.album)

    new_song.should have(1).error_on(:title)
  end

  describe "#price" do
    let(:song) { FactoryGirl.create(:song, price_in_cents: 150) }

    it "returns price in dollars" do
      song.price.should == 1.50
    end
  end

  describe ".on_sale" do
    before do
      FactoryGirl.create(:song, price_in_cents: 300)
      FactoryGirl.create(:song, price_in_cents: 150)
      FactoryGirl.create(:song, price_in_cents: 100)
      FactoryGirl.create(:song, price_in_cents: 80)
    end

    it "returns songs priced $1 or less" do
      Song.on_sale.size.should be 2
    end
  end
end
