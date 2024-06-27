# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Vacation.delete_all
Leader.delete_all
User.delete_all

User.create(email: 'admin@admin.com', password: '12345678')

require 'csv'

csv_file_path = 'collaborators.csv'

CSV.foreach(csv_file_path, headers: true) do |row|
  leader = Leader.find_or_create_by(name: row['Lider'])

  collaborator = Collaborator.find_or_create_by(
    name: row['Nombre'],
    email: row['Email'],
    leader: leader
  )

  Vacation.create(
    collaborator: collaborator,
    start_date: Date.parse(row['Fecha desde']),
    end_date: Date.parse(row['Fecha hasta']),
    vacation_type: row['Tipo'].downcase,
    reason: row['Motivo'],
    status: row['Estado'].downcase
  )
end