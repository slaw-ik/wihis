# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    latitude 1.5
    longitude 1.5
    description "MyText"
  end
end
