Fabricator(:user) do
    liquors(count: 2)
    name {Faker::Name.name}
    username {Faker::Internet.username}
    email {Faker::Internet.free_email #=> "freddy@gmail.com"}
    password {Faker::Internet.password #=> "Vg5mSvY1UeRg7"}