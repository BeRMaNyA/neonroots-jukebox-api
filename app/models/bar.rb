class Bar < ActiveRecord::Base
  attr_accessible :name
  attr_protected :token, :name_downcased

  before_validation :generate_token
  before_validation :downcase_name

  validates :name, :token, presence: true

  validates :token, :name_downcased, uniqueness: true

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(8)
    end while self.class.exists?(token: token)
  end

  def downcase_name
    self.name_downcased = self.name.try(:downcase)
  end
end
