# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_range(range)
  Random.rand(range.count)+range.first
end

require File.expand_path('../seeds/category', __FILE__)
require File.expand_path('../seeds/user', __FILE__)
require File.expand_path('../seeds/group', __FILE__)
require File.expand_path('../seeds/activity', __FILE__)
require File.expand_path('../seeds/blog', __FILE__)
