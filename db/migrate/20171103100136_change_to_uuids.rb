class ChangeToUuids < ActiveRecord::Migration[5.1]
  
  def up
    enable_extension "pgcrypto"

    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()'
    add_column :messages, :uuid, :uuid, default: 'gen_random_uuid()'
    add_column :messages, :user_uuid, :uuid

    Message.find_each do |message|
      message.update user_uuid: message.user.uuid
    end

    remove_column :messages, :user_id
    remove_column :users, :id
    remove_column :messages, :id

    rename_column :users, :uuid, :id
    rename_column :messages, :uuid, :id
    rename_column :messages, :user_uuid, :user_id

    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
    execute "ALTER TABLE messages ADD PRIMARY KEY (id);"

    add_foreign_key "messages", "users"
  end

  def down
  end

end
