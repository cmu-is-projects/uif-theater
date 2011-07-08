module LocationsHelper
  # create a helper to get the options for the location select menu
  def get_location_options
    Location.all.sort_by{|loc| loc.name}.map{|l| ["#{l.name}", l.id] }
  end
end
