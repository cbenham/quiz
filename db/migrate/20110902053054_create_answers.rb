class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.integer :position
      t.integer :question_id
      t.timestamps
    end

    add_index :answers, :question_id, :name => 'by_question'
  end
end
