Here's a more professional version of the `README.md` with the API endpoints presented in a cleaner, more detailed format:

```markdown
# Blog App

A full-stack blogging platform built with **Flutter** for the frontend and **Node.js** with **MongoDB** for the backend. Users can register, login, create posts, like/unlike posts, comment on posts, and manage their profiles.

## Features

- **User Authentication**: Secure user registration and login functionality.
- **Post Management**: Create, read, update, and delete posts.
- **Likes System**: Like and unlike posts.
- **Commenting**: Add, view, and delete comments on posts.
- **User Profiles**: View and update user profiles, including post and like statistics.
- **Post Search**: Search posts by keywords.
- **Post Statistics**: View total number of posts and likes on posts.
- **Logout**: Secure logout functionality.

## Installation & Setup

### Frontend (Flutter)

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd blog-app-flutter
   ```

2. Install the necessary dependencies:
   ```bash
   flutter pub get
   ```

3. Run the Flutter application:
   ```bash
   flutter run
   ```

### Backend (Node.js + MongoDB)

1. Clone the backend repository:
   ```bash
   git clone <repository_url>
   cd blog-app-backend
   ```

2. Install the required dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables in a `.env` file:
   ```env
   MONGO_URI=<Your MongoDB URI>
   JWT_SECRET=<Your JWT Secret Key>
   ```

4. Start the backend server:
   ```bash
   npm start
   ```

## API Endpoints

### Authentication

| **Endpoint**            | **Method** | **Description**                         |
|-------------------------|------------|-----------------------------------------|
| `/api/auth/register`    | `POST`     | Register a new user.                   |
| `/api/auth/login`       | `POST`     | Login with email and password.         |

### Posts

| **Endpoint**                                | **Method** | **Description**                                              |
|--------------------------------------------|------------|--------------------------------------------------------------|
| `/api/posts`                               | `GET`      | Retrieve all posts.                                           |
| `/api/posts`                               | `POST`     | Create a new post (authentication required).                 |
| `/api/posts/:id`                           | `GET`      | Retrieve a specific post by ID.                               |
| `/api/posts/:id`                           | `PUT`      | Update a specific post (authentication required).             |
| `/api/posts/:id`                           | `DELETE`   | Delete a specific post (authentication required).             |
| `/api/posts/search`                        | `GET`      | Search posts based on keywords.                               |

### Comments

| **Endpoint**                                | **Method** | **Description**                                              |
|--------------------------------------------|------------|--------------------------------------------------------------|
| `/api/posts/:postId/comments`              | `POST`     | Add a comment to a specific post (authentication required).   |
| `/api/posts/:postId/comments`              | `GET`      | Get all comments for a specific post.                         |
| `/api/comments/:commentId`                 | `DELETE`   | Delete a specific comment (authentication required).          |
| `/api/posts/:postId/comments/count`        | `GET`      | Get the comment count for a specific post.                    |

### Likes

| **Endpoint**                                | **Method** | **Description**                                              |
|--------------------------------------------|------------|--------------------------------------------------------------|
| `/api/posts/:postId/like`                  | `PUT`      | Like or unlike a specific post (authentication required).     |
| `/api/posts/:postId/likes/count`           | `GET`      | Get the like count for a specific post.                       |

### User Profile

| **Endpoint**                                | **Method** | **Description**                                              |
|--------------------------------------------|------------|--------------------------------------------------------------|
| `/api/user/:id`                            | `GET`      | Retrieve the user profile (authentication required).         |
| `/api/user/:id`                            | `PUT`      | Update the user profile (authentication required).           |

## 👤 Authors

- **Your Name** ([GitHub](https://github.com/YourGitHub))

### Contributors

Contributions are welcome! Feel free to open issues or submit pull requests.

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
```

### Key Improvements:
- Added more formal descriptions to the features.
- Made the sections for installation and setup more clear and professional.
- Presented the API endpoints in a detailed, organized table format.
- Ensured each section and endpoint is explained concisely for clarity.
