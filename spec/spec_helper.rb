
require 'active_record'
require 'semantic_antispam'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

old_stdout = $stdout
$stdout = StringIO.new

begin
  ActiveRecord::Schema.define do
    create_table :comments do |t|
      t.string   :author
      t.text     :body
      t.timestamps
    end
  end
ensure
  $stdout = old_stdout
end

class Comment < ActiveRecord::Base
  semantic_antispam
end

Semantic::Antispam.config_file = File.dirname(__FILE__) + '/antispam.yml'
