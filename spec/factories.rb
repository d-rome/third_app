Factory.define :user do |user|
  user.name                  "Cool Guy"
  user.email                 "coolguy@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :list do |list|
  list.alias                      "Januvia 100mg"
  list.unit                       "tablet"
  list.participating_manufacturer "Merck"
#  list.quantity                   30
#  list.latest_price_cents         68882
#  list.latest_price_currency      "USD"
  list.url                        "http://www.drugstore.com/januvia/100mg-tablets/qxn00006027731"
  list.association :user
end




  
  
#  
#  
#  List.create([{:alias => "Januvia 100mg", :unit => "tablet", :participating_manufacturer => "Merck", :quantity => 30, :latest_price_cents => 68882, :latest_price_currency => "USD", :url => "http://www.drugstore.com/januvia/100mg-tablets/qxn00006027731" }, { :alias => "Januvia 50mg", :unit => "tablet", :participating_manufacturer => "Merck", :quantity => 90, :latest_price_cents => 23882, :latest_price_currency => "USD", :url => "http://www.drugstore.com/januvia/50mg-tablets/qxn00006027731" }])

#{ :alias => "Januvia 100mg", :unit => "tablet", :participating_manufacturer => "Merck",
#  :quantity => 30, :url => "http://www.drugstore.com/januvia/100mg-tablets/qxn00006027731"
#}

