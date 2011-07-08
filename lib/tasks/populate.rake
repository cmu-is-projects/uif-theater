namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # ----------------------------------
    # Step 1: clear any old data in the db
    [Category, Gender, Organization, Item, Note, Location, User, ItemCategory, ItemGender].each(&:delete_all)
    
    # ----------------------------------
    # Step 2: add some categories, genders and organizations to work with (small set for now...)
    # categories = %w[Costumes Props Staging]
    categories = {"Costumes" => ["Blouses", "Button-Up Tops", "Dance Costumes", "Dresses", "Jackets", "Pants", "Shirts", "Skirts", "Vests"], 
                  "Props" => ["Animal", "Ethnic/Period", "Household", "Mystical", "Novelty", "Occupation", "Shoes"], 
                  "Staging" => ["Furniture", "Lighting", "Platform"]}
    categories.sort.each do |category|
      c = Category.new
      c.name = category[0]
      c.save!
      category[1].each do |subcat|
        sc = Category.new
        sc.name = subcat
        sc.subcategory_of = c.id
        sc.save!
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
    ["Gabrielle","Buchanan","gabriellebuc@msn.com","admin",3],
    ["Kahlil","Wallace","kahlil.wallace87@gmail.com","admin",3],
    ["Jalicia","Price","jalicia21@gmail.com","partner",2],
    ["Tanesha","Miller","tmiller.techport@gmail.com","partner",2],
    ["David","Munyaka","david.munyaka@kysu.edu","partner",1],
    ["Wayne","Dennis","wayne.dennisjr@gmail.com","partner",1],
    ["Devany","Brown","devanybrown@gmail.com","coordinator",3],
    ["James","Johnson","arthurj.johnson3@gmail.com","partner",1],
    ["Roneeka","Alexander","ronee.alexander@urbanimpactpittsburgh.org","coordinator",3],
    ["Michelle","Obama","firstlady@whitehouse.gov","partner",1],
    ["Barrack","Obama","president@whitehouse.gov","partner",1]]
    
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
    st_units = ("A".."D").to_a
    containers = (1..4).to_a
    
    st_types.sort.each do |stype|
      st_units.sort.each do |sunit|
        if stype == "floor"
          l = Location.new
          l.storage_type = stype
          l.storage_unit = sunit
          l.save!
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
    
    # ----------------------------------
    # Step 4: add some items to the system
    items = [
      ["Persian Rug","A Persian (think) rug","rug, persian",1,"/uploads/photo/image/2/rug.jpg"],
      ["Razor","An old-fashion razor","razor, antique",22,"/uploads/photo/image/4/razor.jpg"],
      ["Telephone","An old-fashion telephone","telephone, antique",25,"/uploads/photo/image/6/telephone.jpg"],
      ["Black Glove","A cool looking black glove","glove, black",21,"/uploads/photo/image/1/glove.jpg"],
      ["Top Hat","An old-fashion top hat","top hat, old",21,"/uploads/photo/image/3/top_hat.jpg"],
      ["Batman costume","A cool looking Batman costume","batman, black",5,"/uploads/photo/image/5/batman.jpg"], 
      ["Nutcracker costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker2 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker3 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker4 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker5 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker6 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker7 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker8 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker9 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker10 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker11 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"],
      ["Nutcracker12 costume","Full nutcracker costume","nutcracker, christmas",9,"/uploads/photo/image/7/nutcracker.jpg"]
    ]
    
    items.each do |item|
      i = Item.new
      i.name = item[0]
      i.description = item[1]
      i.keywords = item[2]
      i.status = "available"
      i.quantity = 1
      i.location_id = item[3]
      i.save!
    end
    
    # Connect these items to genders
    (4..7).to_a.each do |i_id|
      ig = ItemGender.new
      ig.item_id = i_id
      if i_id == 4
        ig.gender_id = 3
      else
        ig.gender_id = 1
      end
    end 
    
    # Connect these items to categories
    (1..7).to_a.each do |i_id|
      ic = ItemCategory.new
      ic.item_id = i_id
      if i_id < 4
        ic.category_id = 3
      else
        ic.category_id = 1
      end
    end 
  end
end
