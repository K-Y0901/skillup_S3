class ChangeMailsToMailings < ActiveRecord::Migration[5.2]
  def change
    rename_table :mails, :mailings
  end
end
