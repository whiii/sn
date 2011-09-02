module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    
    when /^the new photo page for album "([^"]+)" of user with email "([^"]+)"$/
       new_album_photo_path(Album.where(:user_id => User.find_by_email($2).id, :name => $1).first)

    when /the album "([^"]+)" of user with email "([^"]+)"/
      album_path(Album.where(:user_id => User.find_by_email($2).id, :name => $1).first)
    
    when /^the album list of user with email "([^"]+)"$/
      user_albums_path(User.find_by_email($1))

    when /^the contact list of user with email "([^"]+)"$/
      user_contacts_path(User.find_by_email($1))

    when /^the profile page of user with email "([^"]+)"$/
      profile_path(User.find_by_email($1).profile)

    when /^the sign in page$/
      new_user_session_path

    when /^the edit profile page of user with email "([^"]+)"$/
      edit_profile_path(User.find_by_email($1).profile)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
