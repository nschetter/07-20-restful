unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |table|
    table.text :email
    table.text :name
    table.text :password
  end
end