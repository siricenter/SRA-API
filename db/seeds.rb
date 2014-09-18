# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'E
#   manuel', city: cities.first)
public_role = Role.create(name: "public")

#admin_role = Role.create(name: "admin")
#admin = User.new({email: "admin@admin.com", password: "abc123456", password_confirmation: "abc123456"})
#admin.roles << admin_role
#admin.save

manager_role = Role.create(name: "manager")
#manager = User.new({email: "manager@manager.com", password: "abc123456", password_confirmation: "abc123456"})
#manager.roles << manager_role
#manager.save

field_worker = Role.create(name: "field worker")
#worker = User.new({email: "worker@worker.com", password: "abc123456", password_confirmation: "abc123456"})
#worker.roles << worker_role
#worker.save

#Permission.create([
#	{name: "Create Household"}, 
#	{name: "Edit Household"}])

#field_worker = Role.find_by_name("Field Worker")
#field_worker.permissions << Permission.find_by_name("Create Household")
#field_worker.permissions << Permission.find_by_name("Edit Household")

kyiv = Area.create(name: 'Kyiv')
user = User.create(email: 'email@email.com')
region = Region.create(name: 'Merica')

areas_users = AreasUser.new
areas_users.area = kyiv
areas_users.user = user
areas_users.save

role = manager_role
user.roles = role
user.save

areas_regions = AreasRegion.new
areas_regions.area = kyiv
areas_regions.region = region
areas_regions.save

household = Household.create(id: 1, name: 'Ivanovich')
household.area = kyiv
household.save

person = Person.create(given_name: 'Johnny', family_name: 'Ivanovich', birthday: Time.now, education_level: 'some college', gender: "male", in_school: true, household: household)
person.household = household
person.save

occupation = Occupation.create(name: 'Pipe Mover')

job = Job.create(title: "Web Developer", seasonal: true, description: 'types alot')
job.occupation = occupation
job.person = person
job.save

interview = Interview.create(roof: 'tin',wall: 'stucco',floor: 'wood',bedroom_count: 2, separate_kitchen: true, light: 'lantern', fuel_type: 'gas', water_source: 'river',water_chlorinated: true, bathroom: 'outhouse', sewage: 'septic',total_income: 1500, income_unit: 'pesos',shoe_cost: 25, shoe_unit: 'pesos',medicine_cost: 75, medicine_unit: 'pesos', school_cost: 100,school_unit: 'pesos',college_cost: 1000, college_unit: 'pesos',water_electric_cost: 10, water_electric_unit: 'pesos',misc_cost: 0,misc_unit: 'pesos',radio: true,tv: true, refrigerator: false)
interview.household = household
interview.save

consumed_foods = ConsumedFood.create(n_id: "513fceb575b8dbbc21001506", servings: 3, frequency: 'daily')
consumed_foods.interview = interview
consumed_foods.save

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

