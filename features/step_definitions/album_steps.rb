Given /^user with email "([^"]*)" has album "([^"]*)"$/ do |email, album_name|
  u = User.find_by_email(email)
  Factory(:album, :user => u, :name => album_name)
end

Given /^user "([^"]*)\/([^"]*)" uploaded "([^"]*)" in "([^"]*)"$/ do |email, password, photo, album|
  Given %{user with email "#{email}" has album "#{album}"}
  When %{I sign in as "#{email}/#{password}"}
  And %{I go to the new photo page for album "#{album}" of user with email "#{email}"}
  And %{I choose "#{photo}" file for "Image"}
  And %{I fill in "Comment" with "#{photo}"}
  And %{I press "Upload"}
end