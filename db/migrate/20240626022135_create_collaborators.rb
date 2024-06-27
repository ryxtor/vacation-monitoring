class CreateCollaborators < ActiveRecord::Migration[7.1]
  def change
    create_table :collaborators do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :leader, null: false, foreign_key: true

      t.timestamps
    end
  end
end
