Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  #password { Faker::Lorem::word }
  name { Faker::Name::name }
  first_name { Faker::Name::name }
  timezone { TZInfo::Timezone.all.sample.identifier }
  preferred_hour {rand(22) + 1 }
  preferred_min { [0,15,30,45].sample }
end