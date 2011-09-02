class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :choice_id
      t.timestamps
    end

    add_index :questions, :choice_id, :name => 'by_choice'
  end
end
