# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: "public")

admin_role = Role.create(name: "admin")
admin = User.new({email: "admin@admin.com", password: "abc123456", password_confirmation: "abc123456"})
admin.roles << admin_role
admin.save

manager_role = Role.create(name: "manager")
manager = User.new({email: "manager@manager.com", password: "abc123456", password_confirmation: "abc123456"})
manager.roles << manager_role
manager.save

worker_role = Role.create(name: "field worker")
worker = User.new({email: "worker@worker.com", password: "abc123456", password_confirmation: "abc123456"})
worker.roles << worker_role
worker.save

#Permission.create([
#	{name: "Create Household"}, 
#	{name: "Edit Household"}])





#field_worker = Role.find_by_name("Field Worker")
#field_worker.permissions << Permission.find_by_name("Create Household")
#field_worker.permissions << Permission.find_by_name("Edit Household")

relationships = [
	{name: "Grandfather"},
	{name: 	"Grandmother"},
	{name: 	"Father"},
	{name: 	"Mother"},
	{name: 	"Daughter"},
	{name: 	"Son"},
	{name: 	"Niece"},
	{name: 	"Nephew"},
	{name: 	"Aunt"},
	{name: 	"Uncle"},
	{name: 	"Cousin"},
	{name: 	"Friend"},
	{name: 	"Roommate"},
	{name: "Other"}
]

FamilyRelationship.create(relationships)

occupations = [
	{name: "Farmer"},
	{name: "Construction Worker"},
	{name: "Craftsman"},
	{name: "Trader"},
	{name: "Transport"},
	{name: "Other"}
]

Occupation.create(occupations)
