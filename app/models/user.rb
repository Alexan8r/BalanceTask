class User < ApplicationRecord
  validates :name, :surname, presence: true

  has_many :events, class_name: 'Event', dependent: :destroy

end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  balance    :decimal(16, 2)   default(0.0)
#  name       :string           not null
#  surname    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
