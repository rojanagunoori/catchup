# CatchUp

[![Rails](https://img.shields.io/badge/Rails-8.0-informational?style=flat-square)](https://rubyonrails.org/)  
[![Ruby](https://img.shields.io/badge/Ruby-3.2-red?style=flat-square)](https://www.ruby-lang.org/)  
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)

<video controls style="max-width: 100%;">
  <source src="https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup.mp4" type="video/mp4">
</video>

<!-- 👉 If video doesn't play, click here:
[▶ Watch Demo](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup.mp4) -->

---

## 📸 Screenshots

## 📸 Screenshots

![Screenshot 1](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup1.png)
![Screenshot 2](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup2.png)
![Screenshot 3](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup3.png)
![Screenshot 4](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup4.png)
![Screenshot 5](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup5.png)
![Screenshot 6](https://raw.githubusercontent.com/rojanagunoori/catchup/main/public/catchup6.png)

**CatchUp** is a social networking platform built with **Ruby on Rails**. Users can share thoughts, like and comment on posts, manage friendships, and experience real-time updates via ActionCable.

**Live Demo:** [https://catchup-1-lj7q.onrender.com](https://catchup-1-lj7q.onrender.com)  
**GitHub Repository:** [https://github.com/rojanagunoori/catchup](https://github.com/rojanagunoori/catchup)

---

## 1. Project Overview

CatchUp is designed to help users **connect, share, and engage**. Unlike generic social apps, it emphasizes simplicity with a clean UI, real-time interactions, and easy management of friends and posts.

**Purpose:**

- Connect with friends
- Share thoughts in real-time
- Like, comment, and interact with friends’ posts

---

## 2. 🚀 Features

CatchUp offers a comprehensive set of features designed to make social interactions smooth, secure, and real-time. Each feature has been carefully implemented with Rails, JavaScript, and CSS to ensure a seamless user experience.

| Feature                 | Description                                                                                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **User Authentication** | Users can securely sign up, log in, log out, and reset their password. Authentication is handled with **bcrypt** for hashed passwords, session tokens for secure sessions, and Rails’ built-in CSRF protection.     |
| **Profile Management**  | Users can update their profiles, including changing their **profile picture** and writing an “About Me” section. Profiles also display the number of friends and posts for social context.                          |
| **Thought Management**  | Users can **create, read, edit, and delete posts**, called “Thoughts.” Thoughts are displayed in a feed with timestamps and author information. Post actions are authorized so only the creator can edit or delete. |
| **Likes & Comments**    | Users can **like posts** and **add comments**. Like counts are dynamically updated, and comments can be toggled open or closed. All interactions are powered by **ActionCable** for **real-time updates**.          |
| **Friend System**       | Users can send friend requests, **accept or reject** incoming requests, and manage their friendships. Friendships are tracked with status enums to handle pending, accepted, and rejected states.                   |
| **Real-Time Updates**   | Using **ActionCable**, the app provides instant updates for likes, comments, and friend requests without needing page refreshes. This ensures a smooth and dynamic social experience.                               |
| **Responsive UI**       | The interface is built with **CSS Grid and Flexbox** for layout and **animations** for transitions. Fully mobile-friendly and adaptive to different screen sizes.                                                   |

---

## 3. Project Structure

```bash
catchup/
├─ app/
│  ├─ controllers/       # Handles requests & responses
│  │  ├─ users_controller.rb
│  │  ├─ thoughts_controller.rb
│  │  ├─ comments_controller.rb
│  │  ├─ friendships_controller.rb
│  │  └─ friend_requests_controller.rb
│  ├─ models/            # Data models & associations
│  │  ├─ user.rb
│  │  ├─ thought.rb
│  │  ├─ comment.rb
│  │  └─ friendship.rb
│  ├─ views/             # HTML templates with ERB
│  │  ├─ users/
│  │  ├─ thoughts/
│  │  └─ shared/
│  ├─ channels/          # ActionCable for live updates
│  └─ assets/            # CSS, JS, images
├─ config/
│  ├─ routes.rb          # Application routes
│  ├─ database.yml       # Database config
│  └─ environment.rb
├─ db/
│  ├─ migrations/        # Database migrations
│  └─ schema.rb          # Database schema
├─ Gemfile               # Ruby dependencies
└─ README.md
```

---

## 4. Tech Stack / Environment

Backend: Ruby on Rails 8.0
Frontend: HTML5, CSS3, JavaScript
Database: SQLite (dev/test), PostgreSQL (production)
Real-Time Updates: ActionCable
File Uploads: Active Storage
Required Environment Variables

```bash
CATCHUP_DB_NAME=your_db_name
CATCHUP_DB_USER=your_db_user
CATCHUP_DB_PASSWORD=your_db_password
CATCHUP_DB_HOST=your_db_host
```

---

## 5. Installation / Setup

1. Clone the repository:

```bash
git clone https://github.com/rojanagunoori/catchup.git
cd catchup
```

2. Install Ruby gems:

```bash
bundle install
```

3. Install JavaScript dependencies:

```bash
yarn install or npm install
```

4. Setup database:

```bash
rails db:create
rails db:migrate
rails db:seed   # optional, for dummy data
```

5. Run the server:

```bash
rails server
```

6. Visit in browser: http://localhost:3000

---

## 6. API Endpoints

| Endpoint              | Method | Description            |
| --------------------- | ------ | ---------------------- |
| `/signup`             | POST   | Register a new user    |
| `/login`              | POST   | Login user             |
| `/logout`             | DELETE | Logout current session |
| `/dashboard`          | GET    | View user dashboard    |
| `/users/:id`          | GET    | View user profile      |
| `/account`            | PATCH  | Update profile info    |
| `/thoughts`           | POST   | Create new thought     |
| `/thoughts/:id/like`  | POST   | Like a thought         |
| `/comments`           | POST   | Add comment            |
| `/friends/:id/add`    | POST   | Send friend request    |
| `/friends/:id/accept` | POST   | Accept friend request  |
| `/friends/:id/reject` | DELETE | Reject friend request  |

### Example: Like a Thought (JS Fetch)

```bash
fetch(`/thoughts/${thoughtId}/like`, {
  method: 'POST',
  headers: { 'X-CSRF-Token': token },
});
```

---

## 7. Key Components

| Component                                            | Description                                                               |
| ---------------------------------------------------- | ------------------------------------------------------------------------- |
| **UsersController**                                  | Handles user signup, login, logout, profile display, and updates          |
| **ThoughtsController**                               | Manages CRUD operations for thoughts (posts)                              |
| **CommentsController**                               | Handles comments on thoughts and nested relationships                     |
| **FriendshipsController & FriendRequestsController** | Manages sending, accepting, and rejecting friend requests                 |
| **ActionCable Channels**                             | Provides **real-time updates** for likes, comments, and friend requests   |
| **Views**                                            | Frontend templates: user profiles, thoughts feed, dashboard, and comments |
| **Models**                                           | ActiveRecord models: User, Thought, Comment, Friendship, Like             |

---

## 8. Security

- Passwords securely hashed using bcrypt
- Session tokens for authentication
- CSRF protection built into Rails
- Authorization checks for editing profiles and deleting posts/comments
- Only authenticated users can perform sensitive actions

---

## 9. Key Components

CatchUp offers a comprehensive set of features designed to make social interactions smooth, secure, and real-time. Each feature has been carefully implemented with Rails, JavaScript, and CSS to ensure a seamless user experience.

| Feature                 | Description                                                                                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **User Authentication** | Users can securely sign up, log in, log out, and reset their password. Authentication is handled with **bcrypt** for hashed passwords, session tokens for secure sessions, and Rails’ built-in CSRF protection.     |
| **Profile Management**  | Users can update their profiles, including changing their **profile picture** and writing an “About Me” section. Profiles also display the number of friends and posts for social context.                          |
| **Thought Management**  | Users can **create, read, edit, and delete posts**, called “Thoughts.” Thoughts are displayed in a feed with timestamps and author information. Post actions are authorized so only the creator can edit or delete. |
| **Likes & Comments**    | Users can **like posts** and **add comments**. Like counts are dynamically updated, and comments can be toggled open or closed. All interactions are powered by **ActionCable** for **real-time updates**.          |
| **Friend System**       | Users can send friend requests, **accept or reject** incoming requests, and manage their friendships. Friendships are tracked with status enums to handle pending, accepted, and rejected states.                   |
| **Real-Time Updates**   | Using **ActionCable**, the app provides instant updates for likes, comments, and friend requests without needing page refreshes. This ensures a smooth and dynamic social experience.                               |
| **Responsive UI**       | The interface is built with **CSS Grid and Flexbox** for layout and **animations** for transitions. Fully mobile-friendly and adaptive to different screen sizes.                                                   |

---

## 10. Challenges Faced During Development

Building CatchUp involved several challenges that required careful problem-solving:

1. **Real-time updates**
   - Challenge: Ensuring likes, comments, and friend actions appear instantly without page reloads.
   - Solution: Integrated **ActionCable channels** to broadcast changes to all connected clients in real-time.

2. **Managing friendship states**
   - Challenge: Users can send, accept, or reject friend requests, and each state must be consistent in the database.
   - Solution: Implemented **status enums** for friend requests and friendships (`pending`, `accepted`, `rejected`), simplifying queries and UI logic.

3. **Responsive design**
   - Challenge: Making the app look good on both desktop and mobile.
   - Solution: Used **CSS Grid and Flexbox** for layout and added **animations and transitions** for a modern and interactive feel.

4. **Profile image handling**
   - Challenge: Uploading, storing, and displaying profile pictures efficiently.
   - Solution: Integrated **Active Storage**, allowing users to upload images which are securely stored and displayed.

5. **Secure authentication**
   - Challenge: Protecting user data and sessions.
   - Solution: Implemented **bcrypt password hashing**, **session token management**, and **Rails CSRF protection** to prevent attacks.

---

## 11. Future Improvements

Planned enhancements for CatchUp include:

- **AJAX-based likes and comments**
  - Currently, interactions refresh like counts in real-time via ActionCable, but AJAX would make posting smoother without waiting for broadcasts.

- **Notifications system**
  - Notify users when a friend request is received, a comment is made, or a post is liked.

- **Progressive Web App (PWA) support**
  - Allow offline access and mobile install for a native-app-like experience.

- **Mobile-first design enhancements**
  - Optimize all screens and interactions for smartphones, tablets, and various devices.

- **Image uploads for posts**
  - Allow users to attach images to their thoughts, using Active Storage for uploads and display.

## 12. Contributing

- Fork the repo
- Create a branch: `git checkout -b feature-name`
- Commit: `git commit -m "Add new feature"`
- Push: `git push origin feature-name`
- Create a Pull Request

## 13. Acknowledgments

- Ruby on Rails documentation
- Poppins font and CSS inspiration
- Online tutorials for ActionCable

---

## 14. License

MIT License © Roja Nagunoori

---

## 15. Author / Contact

**Nagunoori Roja**

- 📧 Email: [nagunooriroja@gmail.com](mailto:nagunooriroja@gmail.com)
- 🌐 GitHub: [https://github.com/rojanagunoori](https://github.com/rojanagunoori)
- 🌐 LinkedIn: [https://www.linkedin.com/in/nagunoori-roja-51b936267/](https://www.linkedin.com/in/nagunoori-roja-51b936267/)
- 🌐 Personal Portfolio: [portfolio-roja.netlify.app](https://portfolio-roja.netlify.app/)
- 🌐 LeetCode: [https://leetcode.com/u/dSdsi6XkI8/](https://leetcode.com/u/dSdsi6XkI8/)
- 🌐 Kaggle: [https://www.kaggle.com/nagunooriroja](https://www.kaggle.com/nagunooriroja)

---

✅ This README is **ready to paste** in your GitHub repo. It’s fully detailed with **features, installation, API usage, and project structure**.

If you want, I can **also add a visual diagram/tree of the app structure and screenshots/GIF demo** to make it **even more professional and attractive** for GitHub visitors.

Do you want me to do that next?
