class Agenda < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  belongs_to :team
  belongs_to :user
  has_many :articles, dependent: :destroy
end
