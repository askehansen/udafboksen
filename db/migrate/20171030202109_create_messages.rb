class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :eboks_id
      t.string :eboks_folder_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
