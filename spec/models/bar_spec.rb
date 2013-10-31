require 'spec_helper'

describe Bar do
  it "must have a name" do
    should have(1).error_on(:name)
  end

  it "must have a token" do
    should_not have(1).error_on(:token)
  end

  it "should not be duplicated" do
    bar = FactoryGirl.create(:bar)
    new_bar = Bar.create(name: bar.name.downcase)

    new_bar.should have(1).error_on(:name_downcased)
  end
end
