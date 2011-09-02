Given /^user with email:"([^"]*)" and password:"([^"]*)"$/ do |email, password|
  Factory(:user, :email => email, :password => password)
end

Given "the following users:" do |table|
  attributes = table.raw[0]
  user_definitions = table.raw[1..(table.raw.length-1)]
  user_definitions.each do |definition|
    user_attributes = Hash.new
    attributes.each_index do |i|
      user_attributes[attributes[i]] = definition[i]
    end
    Factory(:user, user_attributes)
  end
end

Given /^users "([^"]*)" and "([^"]*)" are friends$/ do |first_email, second_email|
  first_user = User.find_by_email(first_email)
  second_user = User.find_by_email(second_email)
  Factory(:friendship, :user => first_user, :target => second_user).accept
end

When /^I am in (.*) browser$/ do |name|
  Capybara.session_name = name
end

When /^I am not signed in$/ do
  Capybara.reset_session!
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not signed in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

When /^I wait for (\d+) seconds?$/ do |secs|
  sleep secs.to_i
end

When /^I click "([^"]*)"$/ do |selector|
  find(selector).click
end

When /^I choose "([^"]*)" file for "([^"]*)"$/ do |file_name, file_input|
  file_input = file_input.to_sym
  file_path = File.join(Rails.root, 'features', 'uploads', file_name)
  attach_file(file_input, file_path)
end

Then /^I should see element with id "([^"]*)"$/ do |element_id|
  if page.respond_to? :should
    page.should have_xpath("//*[@id='#{element_id}']")
  else
    assert page.has_xpath?("//*[@id='#{element_id}']")
  end
end

Then /^I unfocus "([^"]*)"$/ do |element|
  find(element).trigger('blur')
end