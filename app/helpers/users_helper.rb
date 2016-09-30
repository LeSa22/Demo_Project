module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 50 })
  	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  	if user.picture?
  		image_tag(user.picture.url , alt: user.name, class: "gravatar")
  	else
  		image_tag("user.png" , alt: user.name, class: "gravatar")
  	end

  end
end