class CreateLeaders < ActiveRecord::Migration[7.1]
  def change
    create_table :leaders do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
