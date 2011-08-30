Factory.define :user do |f|
  f.firstname 'foo'
  f.lastname 'bar'
  f.password 'foobar'
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

Factory.define :profile do |f|
  f.user Factory.build(:user)
  f.sequence(:user_id)
  f.gender 'Male'  
  f.birth_date 10.years.ago
  f.status 'Hello world'
  f.country 'usa'
  f.city 'ny'
  f.school '123'
  f.phone_number '123123'
  f.skype_id 'qwe123'
  f.icq_number '1234567'
end