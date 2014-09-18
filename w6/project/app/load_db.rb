require 'sqlite3'

def load_db_tables()
	database = SQLite3::Database.new 'social_network.db'

	database.execute('PRAGMA foreign_keys = ON;')

	database.execute_batch <<-SQL
		CREATE TABLE users (
			id INTEGER PRIMARY KEY,
			username VARCHAR(255),
			password VARCHAR(255),
			address VARCHAR(255),
			city VARCHAR(255),
			state VARCHAR(255),
			country VARCHAR(255),
			lat REAL,
			lng REAL
		);

		CREATE TABLE posts (
			id INTEGER PRIMARY KEY,
			content VARCHAR(255),
			timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
		);

		CREATE TABLE user_posts (
			post_id INTEGER PRIMARY KEY,
			user_id INTEGER,
			FOREIGN KEY (post_id) REFERENCES posts(id),
			FOREIGN KEY (user_id) REFERENCES users(id)
		);
		
		CREATE TABLE following (
			id INTEGER PRIMARY KEY,
			user_id INTEGER,
			following_id INTEGER,
			FOREIGN KEY (user_id) REFERENCES users(id),
			FOREIGN KEY (following_id) REFERENCES users(id)
		);
	SQL

	# Start with a single user in the database
	database.execute_batch <<-SQL
		INSERT INTO users 
			(username, password, address, city, state, country, lat, lng)
		VALUES 
			("dstockalper", 8184, "1000 Foster City Blvd", "Foster City", "CA", "United States", 37.5534574, -122.257253)
		;

		INSERT INTO posts
			(content)
		VALUES
			("I am working on a social networking app for the WDI course.")
		;

		INSERT INTO user_posts
			(user_id)	
		VALUES
			(1)
		;

		INSERT INTO posts
			(content)
		VALUES
			("My dog, Charley, has floppy ears.")
		;

		INSERT INTO user_posts
			(user_id)
		VALUES
			(1)
		;

	SQL


end

load_db_tables()