# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create("id"=>1, "name"=>"Baloncesto Sevilla", "active"=>true, "short_code"=>"SEV")
Team.create("id"=>2, "name"=>"CAI Zaragoza", "active"=>true, "short_code"=>"CAI")
Team.create("id"=>3, "name"=>"Dominion Bilbao Basket", "active"=>true, "short_code"=>"BLB")
Team.create("id"=>4, "name"=>"Divina Pastora Joventut", "active"=>true, "short_code"=>"JOV")
Team.create("id"=>5, "name"=>"FC Barcelona Lassa", "active"=>true, "short_code"=>"FCB")
Team.create("id"=>6, "name"=>"Herbalife Gran Canaria", "active"=>true, "short_code"=>"GCA")
Team.create("id"=>7, "name"=>"ICL Manresa", "active"=>true, "short_code"=>"MAN")
Team.create("id"=>8, "name"=>"Iberostar Tenerife", "active"=>true, "short_code"=>"CAN")
Team.create("id"=>9, "name"=>"Laboral Kutxa Baskonia", "active"=>true, "short_code"=>"LAB")
Team.create("id"=>10, "name"=>"Montakit Fuenlabrada", "active"=>true, "short_code"=>"FUE")
Team.create("id"=>11, "name"=>"MoraBanc Andorra", "active"=>true, "short_code"=>"AND")
Team.create("id"=>12, "name"=>"Movistar Estudiantes", "active"=>true, "short_code"=>"EST")
Team.create("id"=>13, "name"=>"UCAM Murcia CB", "active"=>true, "short_code"=>"MUR")
Team.create("id"=>14, "name"=>"Unicaja", "active"=>true, "short_code"=>"UNI")
Team.create("id"=>15, "name"=>"Real Madrid", "active"=>true, "short_code"=>"RMA")
Team.create("id"=>16, "name"=>"RETAbet.es GBC", "active"=>true, "short_code"=>"GBC")
Team.create("id"=>17, "name"=>"Rio Natura Monbus Obr.", "active"=>true, "short_code"=>"OBR")
Team.create("id"=>18, "name"=>"Valencia Basket Club", "active"=>true, "short_code"=>"VBC")


User.create email: "xgarcesmarti@gmail.com", password: "11111111", password_confirmation: "11111111", active: true, super_admin: true
