Factory.define :user do |user|
  user.name                  "Cool Guy"
  user.email                 "coolguy@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :fuser do |user|
  user.name                  "Cool Guy2"
  user.email                 "coolguy2@example.com"
  user.password              "foobar2"
  user.password_confirmation "foobar2"
end
