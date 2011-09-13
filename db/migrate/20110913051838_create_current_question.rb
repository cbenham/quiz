class CreateCurrentQuestion < ActiveRecord::Migration
  def change
    create_table :current_questions do |t|
      t.integer :question_id
      t.timestamps
    end
    add_index :current_questions, :question_id, :name => 'by_current_question'
  end
end
