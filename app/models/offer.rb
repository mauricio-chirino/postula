# == Schema Information
#
# Table name: offers
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Offer < ApplicationRecord

  has_many :requests
  has_many :users, through: :requests
  
end
