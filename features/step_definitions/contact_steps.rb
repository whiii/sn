Given /^the following contacts:$/ do |contacts|
  Contact.create!(contacts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) contact$/ do |pos|
  visit contacts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following contacts:$/ do |expected_contacts_table|
  expected_contacts_table.diff!(tableish('table tr', 'td,th'))
end
