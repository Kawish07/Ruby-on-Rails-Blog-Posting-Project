# Ruby on Rails MVC Architecture Deep Dive

## 📚 Complete Understanding Guide

This document explains how the Model-View-Controller (MVC) pattern works in this blog application.

## 🎯 What is MVC?

MVC is a design pattern that separates an application into three interconnected components:

### **Model** 🗄️
- Manages data and business logic
- Talks to the database
- Contains validations and relationships
- **File Location**: `app/models/`

### **View** 🎨
- Presents data to users (HTML)
- User interface layer
- Templates with embedded Ruby
- **File Location**: `app/views/`

### **Controller** 🎮
- Handles user requests
- Coordinates Model and View
- Contains action methods
- **File Location**: `app/controllers/`

---

## 🔄 Request-Response Cycle

```
┌─────────────────────────────────────────────────────────┐
│                     USER'S BROWSER                       │
│              http://localhost:3000/posts                 │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                 1. ROUTER (config/routes.rb)             │
│   Matches URL to Controller Action: posts#index         │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│       2. CONTROLLER (app/controllers/posts_controller.rb)│
│   def index                                              │
│     @posts = Post.published.recent  ← Queries Model     │
│   end                                                    │
└────────────────────┬────────────────────────────────────┘
                     │
      ┌──────────────┴──────────────┐
      ▼                             ▼
┌──────────────┐           ┌─────────────────┐
│ 3. MODEL     │           │ 4. DATABASE     │
│ (app/models/ │◄─────────►│ (SQLite)        │
│  post.rb)    │           │ posts table     │
└──────┬───────┘           └─────────────────┘
       │
       │ Returns data: [@post1, @post2, ...]
       │
       ▼
┌─────────────────────────────────────────────────────────┐
│           5. VIEW (app/views/posts/index.html.erb)       │
│   <% @posts.each do |post| %>                            │
│     <h2><%= post.title %></h2>                           │
│   <% end %>                                              │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                6. RENDERED HTML RESPONSE                 │
│              Sent back to user's browser                 │
└─────────────────────────────────────────────────────────┘
```

---

## 📝 Real Example: Creating a Blog Post

Let's trace what happens when you create a new blog post:

### Step-by-Step Flow

#### 1️⃣ User Clicks "New Post"
**URL**: `GET /posts/new`

**Router** ([config/routes.rb](config/routes.rb)):
```ruby
resources :posts  # Includes GET /posts/new → posts#new
```

**Controller** ([app/controllers/posts_controller.rb](app/controllers/posts_controller.rb)):
```ruby
def new
  @post = Post.new  # Create empty Post object
end
```

**View** ([app/views/posts/new.html.erb](app/views/posts/new.html.erb)):
```erb
<h1>Create New Post</h1>
<%= render "form", post: @post %>
```

**Result**: User sees a form

---

#### 2️⃣ User Fills Form and Clicks Submit
**URL**: `POST /posts`

**Form Data** (sent to server):
```
post[title] = "My First Post"
post[content] = "This is the content..."
post[published] = true
```

**Router**:
```ruby
resources :posts  # Includes POST /posts → posts#create
```

**Controller**:
```ruby
def create
  # 1. Create new Post with form data
  @post = Post.new(post_params)
  
  # 2. Try to save to database
  if @post.save
    # Success! Redirect to show page
    redirect_to @post, notice: 'Post created!'
  else
    # Validation failed, show form again
    render :new, status: :unprocessable_entity
  end
end

private

def post_params
  # Security: only allow these fields
  params.require(:post).permit(:title, :content, :published)
end
```

**Model** ([app/models/post.rb](app/models/post.rb)):
```ruby
class Post < ApplicationRecord
  # Validate before saving
  validates :title, presence: true,
                    length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, 
                      length: { minimum: 10 }
end
```

**Database**:
```sql
INSERT INTO posts (title, content, published, created_at, updated_at)
VALUES ('My First Post', 'This is the content...', true, '2026-02-12 10:30:00', '2026-02-12 10:30:00');
```

**View** ([app/views/posts/show.html.erb](app/views/posts/show.html.erb)):
```erb
<h1><%= @post.title %></h1>
<p><%= @post.content %></p>
```

**Result**: User sees their new post

---

## 🗂️ File Structure Breakdown

### Models (`app/models/`)

**post.rb**:
```ruby
class Post < ApplicationRecord
  # Validations
  validates :title, presence: true
  
  # Scopes (reusable queries)
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Usage:
  # Post.published.recent
  # → SELECT * FROM posts WHERE published = true ORDER BY created_at DESC
end
```

---

### Controllers (`app/controllers/`)

**posts_controller.rb**:
```ruby
class PostsController < ApplicationController
  # This runs before show, edit, update, destroy
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  def index
    @posts = Post.published.recent
    # Renders app/views/posts/index.html.erb
  end
  
  # GET /posts/:id
  def show
    # @post already set by before_action
    # Renders app/views/posts/show.html.erb
  end
  
  # GET /posts/new
  def new
    @post = Post.new
    # Renders app/views/posts/new.html.erb
  end
  
  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  
  # GET /posts/:id/edit
  def edit
    # @post already set
    # Renders app/views/posts/edit.html.erb
  end
  
  # PATCH /posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end
  
  # DELETE /posts/:id
  def destroy
    @post.destroy
    redirect_to posts_url
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
```

---

### Views (`app/views/`)

#### Layout (`layouts/application.html.erb`):
```erb
<!DOCTYPE html>
<html>
  <head>
    <title>My Rails Blog</title>
    <%= stylesheet_link_tag "application" %>
  </head>
  <body>
    <header>
      <nav>
        <%= link_to "All Posts", posts_path %>
        <%= link_to "New Post", new_post_path %>
      </nav>
    </header>
    
    <main>
      <%= yield %>  <!-- Page content goes here -->
    </main>
  </body>
</html>
```

#### Index View (`posts/index.html.erb`):
```erb
<h1>Blog Posts</h1>

<% @posts.each do |post| %>
  <article>
    <h2><%= link_to post.title, post_path(post) %></h2>
    <p><%= truncate(post.content, length: 200) %></p>
    <%= link_to "Read More", post %>
    <%= link_to "Edit", edit_post_path(post) %>
    <%= link_to "Delete", post, 
                data: { turbo_method: :delete,
                        turbo_confirm: "Are you sure?" } %>
  </article>
<% end %>
```

#### Form Partial (`posts/_form.html.erb`):
```erb
<%= form_with(model: post) do |form| %>
  <div>
    <%= form.label :title %>
    <%= form.text_field :title %>
  </div>
  
  <div>
    <%= form.label :content %>
    <%= form.text_area :content, rows: 10 %>
  </div>
  
  <div>
    <%= form.check_box :published %>
    <%= form.label :published %>
  </div>
  
  <%= form.submit %>
<% end %>
```

---

## 🛣️ Routing Deep Dive

**config/routes.rb**:
```ruby
Rails.application.routes.draw do
  root "posts#index"  # Homepage
  
  # This single line creates 7 routes:
  resources :posts
end
```

**Generated Routes**:
```
      Prefix  Verb    URI Pattern              Controller#Action
        root  GET     /                        posts#index
       posts  GET     /posts                   posts#index
             POST    /posts                   posts#create
    new_post  GET     /posts/new               posts#new
   edit_post  GET     /posts/:id/edit          posts#edit
        post  GET     /posts/:id               posts#show
             PATCH   /posts/:id               posts#update
             DELETE  /posts/:id               posts#destroy
```

**Using Route Helpers**:
```erb
<%= link_to "All Posts", posts_path %>
<!-- Generates: <a href="/posts">All Posts</a> -->

<%= link_to "New Post", new_post_path %>
<!-- Generates: <a href="/posts/new">New Post</a> -->

<%= link_to "View", post_path(@post) %>
<!-- Generates: <a href="/posts/5">View</a> -->

<%= link_to "Edit", edit_post_path(@post) %>
<!-- Generates: <a href="/posts/5/edit">Edit</a> -->
```

---

## 🗄️ Database Layer

### Migration (`db/migrate/20260212000001_create_posts.rb`):
```ruby
class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :published, default: false
      
      t.timestamps  # created_at, updated_at
    end
    
    add_index :posts, :published  # Speed up queries
  end
end
```

### Schema (`db/schema.rb`):
```ruby
ActiveRecord::Schema[7.1].define(version: 2026_02_12_000001) do
  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["published"], name: "index_posts_on_published"
  end
end
```

---

## 🔐 Security: Strong Parameters

Rails protects against mass assignment attacks:

**Bad** (Security Risk):
```ruby
# Anyone could set any field!
@post = Post.new(params[:post])
```

**Good** (Secure):
```ruby
def post_params
  params.require(:post).permit(:title, :content, :published)
end

@post = Post.new(post_params)
```

---

## 💡 Rails Conventions

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Model | Singular, CamelCase | `Post`, `BlogPost` |
| Table | Plural, snake_case | `posts`, `blog_posts` |
| Controller | Plural, suffix with Controller | `PostsController` |
| View folder | Plural, lowercase | `posts/` |
| Variable | snake_case | `@new_post` |

### File Locations

| What | Where |
|------|-------|
| Model | `app/models/post.rb` |
| Controller | `app/controllers/posts_controller.rb` |
| Views | `app/views/posts/*.html.erb` |
| Routes | `config/routes.rb` |
| Migration | `db/migrate/TIMESTAMP_action_name.rb` |

---

## 🎓 Key Takeaways

1. **MVC Separates Concerns**:
   - Models = Data
   - Views = Presentation
   - Controllers = Logic

2. **Rails is Convention-based**:
   - Follow naming conventions
   - Files auto-load based on names

3. **RESTful Design**:
   - Standard CRUD operations
   - Predictable URL patterns

4. **Security First**:
   - Strong parameters
   - CSRF protection
   - SQL injection prevention (via Active Record)

---

## 🚀 Practice Exercises

1. **Trace a request**: Pick a URL and trace through Router → Controller → Model → View

2. **Modify the flow**: Add a new field to the Post model and update all layers

3. **Create new routes**: Add a custom action (e.g., `posts/:id/publish`)

4. **Debug**: Add `puts` statements in controller to see data flow

---

Need more help? Check [README.md](README.md) for detailed explanations!
