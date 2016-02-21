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
      user.boards << FactoryGirl.create(:board)
      3.times do
        user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
      end
    end
  end

  factory :category do
    name "test"
  end

  factory :pinning do
    pin
    user
  end

  factory :board do
    name "My Pins!"
  end
end