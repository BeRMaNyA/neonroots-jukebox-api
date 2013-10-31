class Song < ActiveRecord::Base
  attr_accessible :album, :artist, :price_in_cents, :title

  validates_presence_of :album
  validates_presence_of :artist
  validates_presence_of :price_in_cents
  validates_presence_of :title

  validates_numericality_of :price_in_cents, greater_than_or_equal_to: 0, if: :price_in_cents

  validates_uniqueness_of :title, scope: [:artist, :album]

  def price
    self.price_in_cents / 100.to_f
  end
end
