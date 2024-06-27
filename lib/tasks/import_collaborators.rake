namespace :import do
  desc "Import collaborators and vacations from CSV file"
  task collaborators: :environment do
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

    puts "Collaborators and vacations imported successfully!"
  end
end
