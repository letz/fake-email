class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails, id: false do |t|
      t.string :domain, primary_key: true
    end
  end
end
