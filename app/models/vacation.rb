class Vacation < ApplicationRecord
  belongs_to :collaborator

  enum vacation_type: { incapacidad: 0, vacaciones: 1 }
  enum status: { pendiente: 0, aprobado: 1, rechazado: 2 }

  validates :start_date, :end_date, :vacation_type, :status, presence: true

  delegate :name, to: :collaborator, prefix: true
  delegate :leader, to: :collaborator

  before_save :set_vacation_days

  def self.ransackable_attributes(auth_object = nil)
    ["collaborator_id", "created_at", "end_date", "id", "reason", "start_date", "status", "updated_at", "vacation_days", "vacation_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["collaborator"]
    end

  private

  def set_vacation_days
    self.vacation_days = (end_date - start_date).to_i + 1
  end
end
