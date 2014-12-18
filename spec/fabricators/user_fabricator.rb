Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  #password { Faker::Lorem::word }
  name { Faker::Name::name }
  first_name { Faker::Name::name }
end
