class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      
      t.string :encrypted_ssid
      t.string :encrypted_ssid_iv

      t.string :encrypted_eboks_password
      t.string :encrypted_eboks_password_iv

      t.string :encrypted_eboks_activation_key
      t.string :encrypted_eboks_activation_key_iv

      t.timestamps
    end
  end
end
