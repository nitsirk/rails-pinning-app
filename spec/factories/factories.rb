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
    
    factory :user_with_boards do
      after(:create) do |user|
        user.boards << FactoryGirl.create(:board)
        3.times do
          user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
        end
      end
      factory :user_with_boards_and_followers do
        after(:create) do |user|
          3.times do
            follower = FactoryGirl.create(:user)
            Follower.create(user: user, follower_id: follower.id)
          end
        end        
      end
    end

    factory :user_with_followees do
      after(:create) do |user|
        3.times do
          Follower.create(user: FactoryGirl.create(:user), follower_id: user.id)
        end
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