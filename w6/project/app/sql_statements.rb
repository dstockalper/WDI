SQL_DOES_USERNAME_EXIST = <<-SQL
	SELECT * FROM users WHERE username = ?;
SQL


SQL_GET_ALL_USER_POSTS = <<-SQL
		SELECT * FROM posts
		INNER JOIN user_posts
			ON user_posts.post_id = posts.id
		WHERE user_posts.user_id = ?
		;
	SQL

SQL_GET_ALL_USER_FOLLOWING = <<-SQL
	SELECT * FROM users
		INNER JOIN following 
			ON following.following_id = users.id
		WHERE following.user_id = ?
		;
SQL

SQL_ADD_TO_FOLLOWING = <<-SQL
	INSERT INTO following
		(user_id, followiing_id)
	VALUES
		(?, ?)
	;
SQL

SQL_TEST = <<-SQL
	SELECT * FROM posts WHERE id = ?;
SQL