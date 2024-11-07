# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  offer_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Request < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  # Validación para evitar solicitudes duplicadas
  validates :user_id, uniqueness: { scope: :offer_id, message: "ya ha solicitado esta oferta" }
end
