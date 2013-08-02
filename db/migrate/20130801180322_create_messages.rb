class CreateMessages < ActiveRecord::Migration
  def change
    create_table(:messages , :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.integer :communication_id
      t.integer :user_id
      t.text :body
      t.timestamps
    end

    add_index :messages, [:communication_id]
  end
end
