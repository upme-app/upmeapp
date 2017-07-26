class CreateLandingQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :landing_quizzes do |t|
      t.string :quem
      t.string :curso
      t.string :email

      t.timestamps
    end
  end
end
