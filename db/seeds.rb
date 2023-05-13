# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

3.times { user = User.create!(name: Faker::Name.first_name, photo: Faker::Avatar.image, bio: Faker::Job.title) }

User.all.each do |user|
  5.times do
    post = Post.create!(
      title: Faker::Quotes::Shakespeare.hamlet_quote,
      text: Faker::Quote.matz,
      author: user,
      comments_counter: 0,
      likes_counter: 0
    )

    10.times do
      author = User.order('RANDOM()').first
      Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author:, post:)
    end

    5.times do
      author = User.order('RANDOM()').first
      Like.create!(author:, post:)
    end
  end
end