class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  enum status: [:pago, :aguardando, :recusado]
end
