namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :heroku_populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # ----------------------------------
    # Step 1: clear any old data in the db
    [Category, Gender, Organization, Item, Note, Location, User, ItemCategory, ItemGender].each(&:delete_all)
    
    # ----------------------------------
    # Step 2: add some categories, genders and organizations to work with
    # categories = %w[Costumes Props Staging]
    categories = {"Costumes" => [["Blouses"], ["Button-Up Tops"], ["Capes"], ["Dance Costumes"], ["Dresses"], ["Jackets"], ["Pants"], ["Shirts"], ["Skirts"], ["Sleepware"], ["Outerwear"], ["Robes"], ["Vests"]], 
                  "Props" => [["Animal", "Bear", "Frog"], 
                              ["Ethnic/Period", "African", "Asian", "Egyptian", "European", "Hawaiian", "Historical", "Holiday", "International", "Medieval", "Middle Eastern", "Pirate", "Spanish", "Western"], 
                              ["Household", "Books", "Dishes", "Decor"], 
                              ["Mystical", "Angel", "Devil", "Fairytale", "Future", "Witch",	"Wizard"], 
                              ["Novelty", "Celebrity", "Clown", "Dolls", "Eye Glasses", "Food", "Hats", "Humor", "Jewelry", "Magic", "Masks", "Wigs", "Weapon"], 
                              ["Occupation", "Astronaut", "Doctor/Medical", "Military", "Police", "Religion", "Sports"], 
                              ["Shoes", "Boots", "Dance Shoes", "Dress Shoes"]], 
                  "Staging" => [["Furniture"], ["Lighting"], ["Platform"]]}
    categories.sort.each do |base, subs|
      c = Category.new
      c.name = base
      c.save!
      subs.each do |subcat|
        sc = Category.new
        sc.name = subcat[0]
        sc.subcategory_of = c.id
        sc.save!
        unless subcat.size == 1
          subcat.slice!(0)
          subcat.each do |ssub_cat|
            ssc = Category.new
            ssc.name = ssub_cat
            ssc.subcategory_of = sc.id
            ssc.save!
          end          
        end
      end
    end
    
    genders = %w[Female Male Neutral]
    genders.sort.each do |gender|
      g = Gender.new
      g.name = gender
      g.save!
    end
    
    orgs = {"Urban Impact" => "801 Union Place, 4th Floor;15212", "Carnegie Mellon" => "5000 Forbes Avenue;15213", "Allegheny Center Alliance Church" => "250 East Ohio Street;15212"}
    orgs.sort.each do |org|
      o = Organization.new
      o.name = org[0]
      street, zip = org[1].split(";")
      o.street = street
      o.city = "Pittsburgh"
      o.zip = zip
      o.active = true
      o.save!
    end
    
    colors = %w[White Black Charcoal Grey Silver Pink Red Maroon Orange Peach Yellow Pastel\ yellow Gold Tan Bronze Dark\ brown Brown Green Forest\ green Military\ green Lime\ green Sea\ foam\ green Purple Magenta Lavender Violet Blue Navy\ blue Teal Baby\ blue Aqua Rainbow Plaid Polka-dots Stripes]
    colors.sort.each do |color|
      c = Color.new
      c.name = color
      c.save!
    end
    
    # ----------------------------------
    # Step 3: add the team as users to the system
    users = [["Professor","Heimann","profh@cmu.edu","admin",2],
    ["Professor","Quesenberry","jquesenberry@cmu.edu","admin",2],
    ["Gabrielle","Buchanan","gabriellebuc@msn.com","partner",2],
    ["Kahlil","Wallace","kahlil.wallace87@gmail.com","partner",2],
    ["Jalicia","Price","jalicia21@gmail.com","partner",2],
    ["Tanesha","Miller","tmiller.techport@gmail.com","partner",2],
    ["David","Munyaka","david.munyaka@kysu.edu","partner",1],
    ["Wayne","Dennis","wayne.dennisjr@gmail.com","partner",1],
    ["Devany","Brown","devanybrown@gmail.com","partner",1],
    ["James","Johnson","arthurj.johnson3@gmail.com","partner",1],
    ["Roneeka","Alexander","ronee.alexander@urbanimpactpittsburgh.org","coordinator",3],
    ["Eric","Anderson","eric.anderson@urbanimpactpittsburgh.org","admin",3],
    ["Tammy","Glover","tammy.glover@urbanimpactpittsburgh.org","admin",3]]
    
    users.each do |user|
      u = User.new
      u.first_name = user[0]
      u.last_name = user[1]
      u.email = user[2]
      u.role = user[3]
      u.organization_id = user[4]
      if user[1] == "Obama"
        u.status = 0
      else
        u.status = 1
      end
      u.phone = rand(10 ** 10).to_s.rjust(10,'0')
      u.reason = "I love UIF!"
      u.password = "abc123"
      u.password_confirmation = "abc123"
      u.save!
    end
    
    # ----------------------------------
    # Step 4: add some locations to the system
    st_types = %w[floor rack shelf]
    st_units = ("A".."F").to_a
    rack_space = (1..3).to_a
    containers = (1..8).to_a
    
    st_types.sort.each do |stype|
      st_units.sort.each do |sunit|
        if stype == "floor"
          l = Location.new
          l.storage_type = stype
          l.storage_unit = sunit
          l.save!
        elsif stype == "rack"
          rack_space.sort.each do |rs|
            l = Location.new
            l.storage_type = stype
            l.storage_unit = sunit
            l.container = rs
            l.save!
          end
        else
          containers.sort.each do |con|
            l = Location.new
            l.storage_type = stype
            l.storage_unit = sunit
            l.container = con
            l.save!
          end
        end
      end  
    end
  end
end
