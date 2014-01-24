class RemoveTables < ActiveRecord::Migration
  def change
    drop_table :courses
    drop_table :lessons
    drop_table :sublessons
    drop_table :questions
    drop_table :quizzes
    drop_table :answers
    drop_table :users
  end
end
