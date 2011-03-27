require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    User.all(:limit => 6).each do |user|
      45.times do |l|
        aliass = make_words[0] + " #{100+50*l} mg"
        unit = "tablet"
        participating_manufacturer = Faker::Company.name
        quantity = l * 10 + 30
        url = "http://www.drugstore.com/januvia/100mg-tablets/qxn#{l+00006027731}"
        user.lists.create!(:alias => aliass,
                           :unit => unit,
                           :participating_manufacturer => participating_manufacturer,
                           :quantity => quantity,
                           :url => url)
      end
    end
  end
end

def make_words
  Faker::Lorem.words(1)
end

