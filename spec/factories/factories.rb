FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
    id 13
  end

  factory :pin do
    sequence(:slug) { |n| "slug-#{n}"}
    title "Test Pin"
    category_id 1
    url "www.test.com"
    text "description"
  end
end