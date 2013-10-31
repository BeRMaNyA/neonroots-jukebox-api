class Song < ActiveRecord::Base
  MAXIMUM_PRICE_ON_SALE = 100

  attr_accessible :album, :artist, :price_in_cents, :title

  validates :album, :artist, :price_in_cents, :title, presence: true
  validates :title, uniqueness: { scope: [:artist, :album] }

  validates_numericality_of :price_in_cents, greater_than_or_equal_to: 0, if: :price_in_cents

  scope :on_sale, where("price_in_cents <= ?", MAXIMUM_PRICE_ON_SALE)

  def price
    self.price_in_cents / 100.to_f
  end
end
