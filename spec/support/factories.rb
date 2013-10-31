FactoryGirl.define do
  factory :bar do
    name { Faker::Company.name }
  end

  factory :song do
    artist { Faker::Name.name }
    album { Faker::Lorem.sentence(2) }
    title { Faker::Lorem.sentence(2) }
    price_in_cents { rand(50..150) }
  end
end
