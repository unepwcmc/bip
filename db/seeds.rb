# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

indicator_types = ["Pressure", "State", "Benefit", "Response"]
indicator_types.each { |it| IndicatorType.find_or_create_by(name: it) }

indicator_classifications = [
  "Operational and included in the CBD's list of indicators",
  "Under development and included in the CBD’s list of indicators",
  "Potential for future use at global and regional levels"
]
indicator_classifications.each { |ic| IndicatorClassification.find_or_create_by(name: ic) }

coverages = ["Global", "Sub-global"]
coverages.each { |c| Coverage.find_or_create_by(name: c) }

