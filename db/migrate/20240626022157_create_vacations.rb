class CreateVacations < ActiveRecord::Migration[7.1]
  def change
    create_table :vacations do |t|
      t.references :collaborator, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :vacation_type, null: false
      t.string :reason
      t.integer :status, null: false

      t.timestamps
    end
  end
end
