# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Post.destroy_all

# Create sample posts
Post.create([
  {
    title: "Welcome to My Blog",
    content: "This is my first blog post! I'm excited to share my thoughts and experiences with you. This blog is built using Ruby on Rails, demonstrating the MVC architecture pattern.",
    published: true
  },
  {
    title: "Understanding Ruby on Rails MVC",
    content: "Model-View-Controller (MVC) is a software design pattern that separates an application into three main components: Models handle data and business logic, Views handle the presentation layer, and Controllers handle user requests and coordinate between models and views.",
    published: true
  },
  {
    title: "Database Migrations in Rails",
    content: "Rails migrations are a convenient way to alter your database schema over time in a consistent way. Migrations use Ruby DSL so you don't have to write SQL by hand, allowing your schema and changes to be database independent.",
    published: true
  },
  {
    title: "Draft Post: Coming Soon",
    content: "This is a draft post that hasn't been published yet. It demonstrates the published flag in our Post model.",
    published: false
  }
])

puts "Created #{Post.count} posts (#{Post.published.count} published)"
