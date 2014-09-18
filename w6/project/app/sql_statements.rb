SQL_DOES_USERNAME_EXIST = <<-SQL
	SELECT * FROM users WHERE username = ?;
SQL


SQL_GET_ALL_CURRENT_USER_POSTS = <<-SQL
		SELECT * FROM posts
		INNER JOIN user_posts
			ON user_posts.post_id = posts.id
		WHERE user_posts.user_id = ?
		;
	SQL

SQL_TEST = <<-SQL
	SELECT * FROM posts WHERE id = ?;
SQL