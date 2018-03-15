Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all
Comment.destroy_all

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

10.times do
  project = Project.create!(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc + 1.day,
              end_date: Time.now.utc + rand(10) + 2.days,
              owner: User.first
            )
            project.categories = [Category.first]

  5.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(100)+1,
    )
  end
end



20.times do
  project = Project.all.sample

  Pledge.create!(
    user: User.all[1..-1].sample,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(10)+1
  )
end

Category.create(:category_name => 'technology')
Category.create(:category_name =>'art')
