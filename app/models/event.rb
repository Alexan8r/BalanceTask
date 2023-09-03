class Event < ApplicationRecord
  validates :user_id, :name, :amount, presence: true
  validates :kind, inclusion: %w[income consumption] # доход, расход
  belongs_to :user
end

# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  amount     :decimal(16, 2)   not null
#  date       :datetime
#  kind       :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#