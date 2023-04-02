#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")

# Function that adds team in the teams table
function add_team() {
TEAM=$1

if [[ $TEAM != "winner" && $1 != "opponent" ]]
then
  # get team_id
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")

  # if not found
  if [[ -z $TEAM_ID ]]
  then
    # insert team
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $TEAM
      fi
  fi
fi
}

function add_game() {
  YEAR=$1
  ROUND=$2
  WINNER=$3
  OPPONENT=$4
  WINNER_GOALS=$5
  OPPONENT_GOALS=$6

  if [[ $YEAR != 'year' ]]
  then
    echo -e "\n"

    # add winner team
    add_team "$WINNER"
    # get winner ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # add opponent
    add_team "$OPPONENT"
    # get opponent ID
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # get game_id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year=$YEAR AND round='$ROUND' AND winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID AND opponent_goals=$OPPONENT_GOALS")
    
    # insert game
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, game: $YEAR, $ROUND, $WINNER, $OPPONENT_ID
    fi
  fi

}

# Main function
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  add_game $YEAR "$ROUND" "$WINNER" "$OPPONENT" $WINNER_GOALS $OPPONENT_GOALS
done
