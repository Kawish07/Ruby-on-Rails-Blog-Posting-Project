# Ruby on Rails Blog Application

A simple blog application built with Ruby on Rails 7 demonstrating the MVC (Model-View-Controller) architecture, database integration, and full CRUD operations.

## 🎯 Learning Objectives

This project is designed to help you understand:
- **MVC Architecture**: How Rails separates concerns into Models, Views, and Controllers
- **Database Integration**: Using Active Record ORM with SQLite
- **RESTful Routing**: Creating proper routes for CRUD operations
- **Frontend Development**: Building views with ERB templates and CSS
- **Rails Conventions**: Following "Convention over Configuration" principles

## 📁 Project Structure

```
Ruby and Rails Project/
├── app/
│   ├── assets/                 # Static assets (CSS, images, JavaScript)
│   │   └── stylesheets/
│   │       └── application.css # Main stylesheet
│   ├── controllers/            # BACKEND: Handle HTTP requests
│   │   ├── application_controller.rb
│   │   └── posts_controller.rb # CRUD operations for blog posts
│   ├── models/                 # DATABASE LAYER: Business logic & data
│   │   ├── application_record.rb
│   │   └── post.rb            # Post model with validations
│   ├── views/                 # FRONTEND: HTML templates
│   │   ├── layouts/
│   │   │   └── application.html.erb  # Main layout wrapper
│   │   └── posts/
│   │       ├── index.html.erb        # List all posts
│   │       ├── show.html.erb         # Show single post
│   │       ├── new.html.erb          # New post form
│   │       ├── edit.html.erb         # Edit post form
│   │       └── _form.html.erb        # Shared form partial
│   └── helpers/               # View helper methods
│
├── config/                    # Configuration files
│   ├── application.rb         # Application configuration
│   ├── database.yml           # Database configuration
│   ├── routes.rb             # URL routing definitions
│   ├── puma.rb               # Web server configuration
│   └── environments/          # Environment-specific configs
│       ├── development.rb
│       ├── production.rb
│       └── test.rb
│
├── db/                        # Database files
│   ├── migrate/              # Database migrations
│   │   └── 20260212000001_create_posts.rb
│   ├── schema.rb             # Current database schema
│   └── seeds.rb              # Sample data
│
├── Gemfile                    # Ruby dependencies
├── config.ru                  # Rack configuration
└── Rakefile                   # Rake tasks

```

## 🏗️ MVC Architecture Explained

### **Model** (app/models/post.rb)
- Represents data and business logic
- Interacts with the database through Active Record
- Contains validations and scopes
- Example: `Post.published.recent` retrieves published posts ordered by date

### **View** (app/views/posts/\*.html.erb)
- Presentation layer (HTML templates)
- Displays data to users
- Uses ERB (Embedded Ruby) to mix HTML with Ruby code
- Example: `<%= @post.title %>` displays the post title

### **Controller** (app/controllers/posts_controller.rb)
- Handles user requests
- Coordinates between Model and View
- Contains actions (methods) for each route
- Example: `index`, `show`, `create`, `update`, `destroy`

## 🗄️ Database Layer

### Migration (db/migrate/20260212000001_create_posts.rb)
Defines the database schema:
```ruby
create_table :posts do |t|
  t.string :title, null: false
  t.text :content, null: false
  t.boolean :published, default: false
  t.timestamps
end
```

### Model Validations (app/models/post.rb)
```ruby
validates :title, presence: true, length: { minimum: 3, maximum: 100 }
validates :content, presence: true, length: { minimum: 10 }
```

## 🛣️ Routes (RESTful API)

The application uses RESTful routing:

| HTTP Verb | Path              | Controller#Action | Purpose                |
|-----------|-------------------|-------------------|------------------------|
| GET       | /posts            | posts#index       | List all posts         |
| GET       | /posts/:id        | posts#show        | Show single post       |
| GET       | /posts/new        | posts#new         | Show new post form     |
| POST      | /posts            | posts#create      | Create new post        |
| GET       | /posts/:id/edit   | posts#edit        | Show edit form         |
| PATCH/PUT | /posts/:id        | posts#update      | Update post            |
| DELETE    | /posts/:id        | posts#destroy     | Delete post            |

## 🚀 Setup and Installation

### Prerequisites
- Ruby 3.2.0 or higher
- Rails 7.1 or higher
- SQLite3

### Installation Steps

1. **Install Dependencies**
   ```bash
   bundle install
   ```

2. **Create Database**
   ```bash
   rails db:create
   ```

3. **Run Migrations**
   ```bash
   rails db:migrate
   ```

4. **Seed Sample Data** (Optional)
   ```bash
   rails db:seed
   ```

5. **Start the Server**
   ```bash
   rails server
   ```

6. **Open in Browser**
   Navigate to: `http://localhost:3000`

## 🎨 Frontend Features

### Styling
- Modern, responsive CSS design
- Card-based layout for post listings
- Form validation with error messages
- Gradient navigation bar
- Mobile-friendly responsive design

### User Interface Components
- **Posts Index**: Grid layout showing all published posts
- **Post Detail**: Full post view with metadata
- **Create/Edit Forms**: User-friendly forms with validation
- **Navigation**: Easy navigation between pages
- **Alerts**: Success/error messages for user actions

## 🔧 Key Rails Concepts Demonstrated

### 1. **Convention over Configuration**
- Automatic mapping between URLs, controllers, and views
- File naming conventions (singular models, plural controllers)
- Database table naming based on model names

### 2. **DRY (Don't Repeat Yourself)**
- Partial views (`_form.html.erb`) for shared code
- Layout templates for consistent page structure
- Helper methods for common functionality

### 3. **Active Record**
- Object-Relational Mapping (ORM)
- Database queries using Ruby syntax
- Automatic timestamps (`created_at`, `updated_at`)

### 4. **Strong Parameters**
Security feature preventing mass assignment:
```ruby
def post_params
  params.require(:post).permit(:title, :content, :published)
end
```

### 5. **Callbacks and Filters**
```ruby
before_action :set_post, only: [:show, :edit, :update, :destroy]
```

## 📊 Database Schema

### Posts Table
| Column      | Type     | Constraints              |
|-------------|----------|--------------------------|
| id          | integer  | Primary Key, Auto-increment |
| title       | string   | Not Null                 |
| content     | text     | Not Null                 |
| published   | boolean  | Default: false           |
| created_at  | datetime | Auto-generated           |
| updated_at  | datetime | Auto-generated           |

## 🧪 Testing the Application

### Manual Testing Steps

1. **Create a Post**
   - Click "New Post"
   - Fill in title and content
   - Check/uncheck "Publish this post"
   - Click "Create Post"

2. **View Posts**
   - Go to "All Posts"
   - See list of published posts
   - Click "Read More" to view full post

3. **Edit a Post**
   - Click "Edit" on any post
   - Modify title or content
   - Save changes

4. **Delete a Post**
   - Click "Delete" on any post
   - Confirm deletion

## 📚 Learning Resources

### Understanding the Code Flow

1. **User visits `/posts`**
   - Router (`config/routes.rb`) maps to `PostsController#index`
   - Controller fetches published posts: `@posts = Post.published.recent`
   - Renders view: `app/views/posts/index.html.erb`
   - Layout wrapper: `app/views/layouts/application.html.erb`

2. **User creates a new post**
   - Clicks "New Post" → `GET /posts/new` → `PostsController#new`
   - Fills form and submits → `POST /posts` → `PostsController#create`
   - Controller validates and saves to database
   - Redirects to post detail page

### File Responsibilities

**Backend (Business Logic)**
- `app/models/` - Data models and database interactions
- `app/controllers/` - Request handling and response logic

**Frontend (Presentation)**
- `app/views/` - HTML templates
- `app/assets/stylesheets/` - CSS styling

**Configuration**
- `config/routes.rb` - URL routing
- `config/database.yml` - Database connection
- `Gemfile` - Ruby dependencies

**Database**
- `db/migrate/` - Database schema changes
- `db/schema.rb` - Current database structure
- `db/seeds.rb` - Sample data

## 🎓 Next Steps for Learning

1. **Add Comments**: Create a Comment model associated with Posts
2. **User Authentication**: Add Devise gem for user login
3. **Categories/Tags**: Organize posts by categories
4. **Search Functionality**: Add search feature
5. **Image Uploads**: Use Active Storage for post images
6. **API**: Create a JSON API endpoint
7. **Testing**: Add RSpec or Minitest tests

## 💡 Common Rails Commands

```bash
# Database commands
rails db:create          # Create database
rails db:migrate         # Run migrations
rails db:seed            # Load seed data
rails db:reset           # Drop, create, migrate, and seed

# Server commands
rails server             # Start web server
rails console            # Interactive Ruby console with app loaded

# Generators
rails generate model Post title:string content:text
rails generate controller Posts index show
rails generate migration AddFieldToTable field:type

# Routes
rails routes             # Show all routes
```

## 🐛 Troubleshooting

**Server won't start?**
- Check if port 3000 is already in use
- Ensure all gems are installed: `bundle install`

**Database errors?**
- Run: `rails db:migrate`
- Reset database: `rails db:reset`

**CSS not loading?**
- Restart the server after CSS changes
- Clear browser cache

## 📝 License

This project is created for educational purposes.

## 🤝 Contributing

This is a learning project. Feel free to experiment and modify!

---

**Happy Learning! 🎉**

For questions or issues, refer to the official [Ruby on Rails Guides](https://guides.rubyonrails.org/).
#   R u b y - o n - R a i l s - B l o g - P o s t i n g - P r o j e c t  
 