class Leader < ApplicationRecord
  has_many :collaborators

  validates :name, presence: true
end
