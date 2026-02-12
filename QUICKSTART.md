# Ruby on Rails Blog - Quick Start Guide

## 🚀 Getting Started in 3 Steps

### Step 1: Install Dependencies
```powershell
bundle install
```

### Step 2: Setup Database
```powershell
rails db:create
rails db:migrate
rails db:seed
```

### Step 3: Start the Server
```powershell
rails server
```

Then open your browser to: **http://localhost:3000**

## 📖 Project Overview

This is a complete blog application demonstrating:
- ✅ **Backend**: Controllers handling CRUD operations
- ✅ **Frontend**: Beautiful views with responsive CSS
- ✅ **Database**: SQLite with Post model and migrations
- ✅ **MVC Pattern**: Proper separation of concerns

## 🎯 What You'll Learn

### 1. **MVC Architecture**
```
Request → Router → Controller → Model → Database
                      ↓
                    View → Response
```

### 2. **Folder Structure**
- `app/models/` - Database models (Post)
- `app/controllers/` - Request handlers (PostsController)
- `app/views/` - HTML templates (ERB files)
- `config/routes.rb` - URL routing
- `db/migrate/` - Database migrations

### 3. **CRUD Operations**
- **C**reate - Add new blog posts
- **R**ead - View all posts or single post
- **U**pdate - Edit existing posts
- **D**elete - Remove posts

## 🔍 Key Files to Study

1. **Routes** - [config/routes.rb](config/routes.rb)
   - Defines URL patterns and maps to controller actions

2. **Model** - [app/models/post.rb](app/models/post.rb)
   - Database schema and validations

3. **Controller** - [app/controllers/posts_controller.rb](app/controllers/posts_controller.rb)
   - Business logic for handling requests

4. **Views** - [app/views/posts/](app/views/posts/)
   - HTML templates for displaying data

5. **Migration** - [db/migrate/20260212000001_create_posts.rb](db/migrate/20260212000001_create_posts.rb)
   - Database table structure

## 💡 Try These Tasks

### Beginner
- [ ] Create a new blog post
- [ ] Edit an existing post
- [ ] Delete a post
- [ ] Toggle the "published" status

### Intermediate
- [ ] Add a new field to Post model (e.g., `author`)
- [ ] Create a migration for the new field
- [ ] Update views to display the new field
- [ ] Add validation for the new field

### Advanced
- [ ] Add a Comment model
- [ ] Create post categories
- [ ] Add image uploads
- [ ] Implement search functionality

## 📚 Understanding the Flow

### Example: Viewing All Posts

1. User visits `http://localhost:3000/posts`
2. **Router** matches `/posts` to `posts#index`
3. **Controller** (`PostsController#index`):
   ```ruby
   def index
     @posts = Post.published.recent
   end
   ```
4. **Model** (`Post`) queries database
5. **View** (`index.html.erb`) renders HTML with `@posts` data
6. **Browser** displays the page

### Example: Creating a Post

1. User clicks "New Post"
2. **Router** matches `/posts/new` to `posts#new`
3. **View** displays form
4. User submits form → `POST /posts`
5. **Controller** (`PostsController#create`):
   ```ruby
   def create
     @post = Post.new(post_params)
     if @post.save
       redirect_to @post
     else
       render :new
     end
   end
   ```
6. **Model** validates and saves to database
7. Redirects to post detail page

## 🛠️ Useful Commands

```powershell
# View all routes
rails routes

# Open Rails console (test Ruby code)
rails console

# Reset database (drop, create, migrate, seed)
rails db:reset

# Check for errors
rails db:migrate:status
```

## 🎨 Customization Ideas

1. **Change Colors**: Edit [app/assets/stylesheets/application.css](app/assets/stylesheets/application.css)
2. **Modify Layout**: Edit [app/views/layouts/application.html.erb](app/views/layouts/application.html.erb)
3. **Add Fields**: Create a new migration
4. **Change Validations**: Edit [app/models/post.rb](app/models/post.rb)

## ❓ Common Questions

**Q: Where is the data stored?**  
A: In `storage/development.sqlite3` (SQLite database)

**Q: How do I add a new page?**  
A: 
1. Add route in `config/routes.rb`
2. Create controller action
3. Create view template

**Q: What if I break something?**  
A: Just run `rails db:reset` to restore to initial state

**Q: How do I see what's in the database?**  
A: Run `rails console`, then try:
```ruby
Post.all
Post.count
Post.first
```

## 🎓 Next Learning Steps

1. **Read the README.md** for detailed explanations
2. **Modify existing code** to see how it affects the app
3. **Add new features** using Rails generators
4. **Follow Rails Guides**: https://guides.rubyonrails.org/

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Server won't start | Run `bundle install` |
| Database error | Run `rails db:migrate` |
| Changes not showing | Restart server (Ctrl+C, then `rails server`) |
| Port 3000 in use | Use `rails server -p 3001` |

---

**Ready to start?** Just run these three commands:

```powershell
bundle install
rails db:setup
rails server
```

Then visit **http://localhost:3000** and start exploring! 🎉
