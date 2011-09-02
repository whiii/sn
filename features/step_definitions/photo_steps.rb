Given /^the following photos:$/ do |photos|
  Photo.create!(photos.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) photo$/ do |pos|
  visit photos_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following photos:$/ do |expected_photos_table|
  expected_photos_table.diff!(tableish('table tr', 'td,th'))
end
