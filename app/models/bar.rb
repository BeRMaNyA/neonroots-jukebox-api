class Bar < ActiveRecord::Base
  attr_accessible :name
  attr_protected :token, :name_downcased

  before_validation :generate_token
  before_validation :downcase_name

  validates_presence_of :name
  validates_presence_of :token

  validates_uniqueness_of :token
  validates_uniqueness_of :name_downcased

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(8)
    end while self.class.exists?(token: token)
  end

  def downcase_name
    self.name_downcased = self.name.downcase if self.name.present?
  end
end
