class CreateUserTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :user_tokens do |t|
      t.references :user, foreign_key: true
      t.references :gym, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
