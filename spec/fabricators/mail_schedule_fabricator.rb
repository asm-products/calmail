Fabricator(:mail_schedule) do
  timezone { TZInfo::Timezone.all.sample.identifier }
  preferred_hour { rand(22) + 1 }
  preferred_min { [0,15,30,45].sample }
end
