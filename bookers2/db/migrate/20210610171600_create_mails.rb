class CreateMails < ActiveRecord::Migration[5.2]
  def change
    create_table :mails do |t|
      t.integer "user_id"
      t.string "title"
      t.text "content"

      t.timestamps
    end
  end
end
