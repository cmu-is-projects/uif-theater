module ApplicationHelper
  def avatar_url(user)  
    default_url = "#{root_url}images/guest.png"  
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"  
  end
  
  def tiny_avatar_url(user)  
    default_url = "#{root_url}images/tiny_guest.png"  
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=24&d=#{CGI.escape(default_url)}"  
  end
  
  def calculate_rows(num_of_items, num_of_columns)
    if num_of_items%num_of_columns == 0
    	rows = num_of_items/num_of_columns - 1
    else
    	rows = num_of_items/num_of_columns
    end
  end
end
