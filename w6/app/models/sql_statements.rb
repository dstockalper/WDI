SQL_DOES_USERNAME_EXIST = <<-SQL
	SELECT * FROM users WHERE username = ?;
SQL