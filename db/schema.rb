# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110912015923) do

  create_table "answers", :force => true do |t|
    t.string   "answer"
    t.integer  "position"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "by_question"

  create_table "answers_numbers", :id => false, :force => true do |t|
    t.integer  "answer_id"
    t.integer  "number_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers_numbers", ["answer_id"], :name => "by_answer"
  add_index "answers_numbers", ["number_id"], :name => "by_number"

  create_table "numbers", :force => true do |t|
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.integer  "choice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["choice_id"], :name => "by_choice"

end
