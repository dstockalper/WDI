# README file for mocroblogging app (WDI - Project 1)
* 9.19.14

## Trello
* link: https://trello.com/b/tBPldxQW/social-network
* Note: I did not make much use of Trello beyond the 45 minutes of class time

## Schema and Tests
* Schema consists of three tables:
  1. users: stores user addresses and map coordinates
  2. posts: stores posts made by users, timestamp, and id of users making the post
  3. following: stores id of users being followed by other users (one-to-many relationship)
* I did not use tests on this project

## Setting Up
* >> ruby load_db.rb to create database with schema (and one-user-two-posts of seed data)
* >> rackup to run main.rb
* navigate to localhost:8080

## The App
* /login
** New users prompted to register, checking for pre-existing username and matching password fields
** User receives cookie and will be auto-logged on future visits and redirected to profile page
** Existing users who explicitly logged out or manually removed their cookie will be directed to the login page, where login checks for existing username and matching password
* /profile
** profile page contains four quadrants: 
*** Top left: Name, location, location-update form, blog-post form
*** Bottom left: History of all user posts, with timestamp (prime meridian), most recent on top
*** Top right: Map, centered on user location, with any followed users marked on the map (note that the map resizes based on distance of farthest user)
*** Bottom right: A panel of all users being followed by me, their distance from me in km, and the most recent blog post for each
* /search
** The search page is accessed from a button on the profile page
** ALL users will be displayed on the search page (I did not have time to implement a filtering function)
** The user can click on any number of users to follow, and they will automatically be populated into the user's map and following panel on the profile page
** Note that the functionality of this page is not good: users can be followed multiple times, and logged-in user can even follow himself...

