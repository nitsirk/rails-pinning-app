FactoryGirl.define do
  sequence :slug do |n|
    "slug#{n}"
  end

  sequence :email do |n|
    "coder#{n}@skillcrush.com"
  end

  factory :pin do
    title "Rails Cheatsheet"
    url "http://rails-cheat.com"
    text "A great tool for beginning developers"
    slug
    category
  end

  factory :user do
    email
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
    
    after(:create) do |user|
      create_list(:pin, 3)
    end
  end

  factory :category do
    name "test"
  end
end