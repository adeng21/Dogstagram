# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :user

    image File.open(File.join(Rails.root, '/spec/fixtures/sleeping_dog.jpeg'))
    trait :with_description do
      sequence(:description) {|n| "Meet doggy#{n}. ARFF ARFF!!"}
    end
  end
end
