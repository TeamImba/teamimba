class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,               :null => false, :default => ""  # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false, :default => ""  # optional, see below
      t.string    :password_salt,       :null => false, :default => ""  # optional, but highly recommended
      t.string    :persistence_token,   :null => false, :default => ""  # required
      t.string    :single_access_token, :null => false, :default => ""  # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false, :default => ""  # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0   # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip,    :null => false, :default => ""  # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip,       :null => false, :default => ""  # optional, see Authlogic::Session::MagicColumns
      t.string    :facebook_id,         :string
      t.timestamps
    end
    
    add_index :users, :email
    add_index :users, :crypted_password
    add_index :users, :password_salt
    add_index :users, :persistence_token
    add_index :users, :single_access_token
    add_index :users, :perishable_token
    add_index :users, :login_count
    add_index :users, :failed_login_count
    add_index :users, :last_request_at
    add_index :users, :current_login_at
    add_index :users, :last_login_at
    add_index :users, :current_login_ip
    add_index :users, :last_login_ip
  end

  def self.down
    drop_table :users
  end
end
