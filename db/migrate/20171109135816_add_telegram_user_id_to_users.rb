class AddTelegramUserIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telegram_user_id, :string
  end
end
