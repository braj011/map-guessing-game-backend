# LDN Knowledge Backend
## test your knowledge of London... improve it... or just guess wildly for fun!

#### Game live at https://ldn-knowledge.herokuapp.com/ - the backend will take a few seconds to wake up on first play. It is playable once the high scores are displayed.

#### Ruby on Rails backend, with a Javascript frontend here: https://github.com/CiaranMn/map-guessing-game-frontend

<img src="demo.gif" alt="short clip of gameplay" width="60%" height="auto">

## How the game works
- A game starts once a player has entered a name and either selects a difficulty, or hits enter (which begins an easy game)
- A static map centered around a random London postcode is displayed to the user, initially obscured by 9 squares
- As soon as the game begins, one square is removed, with the remainder gradually fading over the course of the game
- A player guesses the location of the map from the 10 options to the right - the options being London constituencies
- Points are deducted for incorrect guesses
- The game ends when a correct guess is made or the timer runs out (at which point the player's score will be 1 if no incorrect guesses have been made)
- The user may restart the game by clicking anywhere on the main container or pressing any key.
- The player's final score, rank in the high scores table and surrounding scores are shown at the end of the game
- On **easy** difficulty the names of train stations, schools, churches and businesses are labelled, and a fairly large area is shown (google zoom level 15). The score starts at 1,000 and 100 points are deducated for an incorrect guess
- On **medium** difficulty the labels are removed. Zoom is the same as easy. Score starts at 1,500 with 150 points deducted for an incorrect guess
- On **hard** difficulty the labels are removed. A smaller area is provided at a higher zoom (google 17). Score starts at 2,000 with 200 points deducted for an incorrect guess.

## Backend Structure
The **database** is Postgresql and requires rails db:create, rails db:migrate and rails db:seed before the server is started.
It has tables for areas (i.e. London areas), scores, and users. There is no user authentification - scores will be assigned to the user with the name the player enters if that name already exists, with a new one created if not.

The areas table is seeded from csvs which contain around 120,000 London postcodes, downloaded from https://www.doogal.co.uk/UKPostcodes.php - to keep under Heroku's limit of 10,000 db rows for free dynos, only 1 in every 15 is inserted in the db for around 8,000 records.

### The following files in app/ do the heavy lifting:
- **areas controller**: on get request picks a random sample of 10 London areas from the database, unique by constituency (to avoid duplicate options appearing to the player, who guesses by area constituency name), and instantiates a new Image with the difficulty and seed provided by the frontend, to fetch and save the appropriate static map from google. 
- **image model** when instantiated will request a static map image from Google with custom styling, with zoom level and some labels depending on difficulty level, generates a filename - the last 5 digits of which correspond to the winning area's id after transformation by the seed so that the frontend can identify the correct answer from the 10 supplied - and writes the map image to the file system.

- **scores controller**: provides the top 10 scores to display on the welcome screen. on post request finds or creates a user from the username, reates a score record from the area_id, difficulty, score, and user_id, and deletes the image file used in the game from the file system (as no longer required).
- **scores model**: contains methods to determine the rank of a score (by score!) among all scores, and to identify 9 scores around the score so that the user can be shown their position in the table with scores immediately around them. the model actually determines the *index* of the score in the ranke table, and the score serializer deals with adding 1 to provide a rank (as well as populating the name of the user associated with the score).


### API endpoints:
- **GET '/api/v1/areas'** - expects params to contain 'difficulty' (one of 'easy', 'medium', 'hard') and 'seed'. Responds with an array of 10 areas, and the filename of the map image
- **GET '/api/v1/images/:filename'** - sends the image file requested
- **GET '/api/v1/scores'** - responds with the top 10 scores
- **POST '/api/v1/scores'** - expects an area_id, difficulty, score, username, and filename. Responds with the score record, and a list of 10 scores including the player's score and the 9 scores ranked around it in the high scores table - **or** responds with errors if the score cannot be saved (e.g. fails valdiations in app/models/scores.rb - which should not happen unless the frontend logic is interfered with). 

### N.B.
1. config/initializers/cors.rb is set to only allow requests from the frontend deployment at ldn-knowledge.herokuapp.com which should be changed if frontend used from elsewhere
2. app/models/image.rb expects a valid Google API key in an environment variable GOOGLE_API
