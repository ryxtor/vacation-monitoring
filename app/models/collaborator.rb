class Collaborator < ApplicationRecord
  belongs_to :leader
  has_many :vacations

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "leader_id", "name", "updated_at"]
    end
end
