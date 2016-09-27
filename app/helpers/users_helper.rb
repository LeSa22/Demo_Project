module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag('user.png', alt: user.name, class: "gravatar")
  end
end