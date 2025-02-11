document.addEventListener("DOMContentLoaded", function () {
    // Like/Dislike Functionality
    document.querySelectorAll(".like-btn").forEach((button) => {
      button.addEventListener("click", function () {
        const thoughtId = this.dataset.thoughtId;
        const likeCountSpan = this.querySelector(".like-count");
  
        fetch(`/thoughts/${thoughtId}/toggle_like`, {
          method: "POST",
          headers: { "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content },
        })
          .then((response) => response.json())
          .then((data) => {
            likeCountSpan.textContent = data.likes_count;
            this.classList.toggle("liked", data.liked);
          });
      });
    });
  
    // Adding Comments
    document.querySelectorAll(".add-comment").forEach((button) => {
      button.addEventListener("click", function () {
        const thoughtItem = this.closest(".thought-item");
        const thoughtId = thoughtItem.dataset.thoughtId;
        const commentInput = thoughtItem.querySelector(".comment-input");
        const commentsList = thoughtItem.querySelector(".comments-list");
  
        fetch(`/thoughts/${thoughtId}/comments`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          },
          body: JSON.stringify({ comment: { content: commentInput.value } }),
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.comment) {
              const commentHTML = `
                <div class="comment-item" data-comment-id="${data.comment.id}">
                  <strong>${data.user_name}</strong>: ${data.comment.content}
                  <button class="like-comment-btn" data-comment-id="${data.comment.id}">
                    <i class="fas fa-heart"></i> <span class="comment-like-count">0</span>
                  </button>
                </div>
              `;
              commentsList.innerHTML += commentHTML;
              commentInput.value = "";
            }
          });
      });
    });
  
    // Like/Dislike Comments
    document.addEventListener("click", function (event) {
      if (event.target.closest(".like-comment-btn")) {
        const button = event.target.closest(".like-comment-btn");
        const commentId = button.dataset.commentId;
        const likeCountSpan = button.querySelector(".comment-like-count");
  
        fetch(`/comments/${commentId}/toggle_like`, {
          method: "POST",
          headers: { "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content },
        })
          .then((response) => response.json())
          .then((data) => {
            likeCountSpan.textContent = data.likes_count;
            button.classList.toggle("liked", data.liked);
          });
      }
    });
  });
  