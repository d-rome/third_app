# == Schema Information
# Schema version: 20110325043717
#
# Table name: lists
#
#  id                         :integer         not null, primary key
#  alias                      :string(255)
#  latest_price_cents         :integer
#  latest_price_currency      :string(255)
#  unit                       :string(255)
#  participating_manufacturer :string(255)
#  quantity                   :integer
#  url                        :string(255)
#  user_id                    :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#

class List < ActiveRecord::Base
  attr_accessible :alias, :unit, :participating_manufacturer,
                  :quantity, :latest_price_cents, :latest_price_currency, :url
  belongs_to :user
  
  default_scope :order => 'lists.created_at DESC'

composed_of :latest_price,
  :class_name => "Money",
  :mapping => [%w(latest_price_cents latest_price_cents), %w(latest_price_currency currency_as_string)],
  :constructor => Proc.new {
    |latest_price_cents, latest_price_currency| Money.new(latest_price_cents ||
    0, latest_price_currency || Money.default_currency)
  },
  :converter => Proc.new {
    |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError,
    "Can't convert #{value.class} to Money")
  }

end
