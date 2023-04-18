#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

MAIN_MENU(){
  NUMBER_TO_GUESS=$(GENERATE_RANDOM_NUMBER)
  GET_USER_INFO
  PLAY_GAME $NUMBER_TO_GUESS
  SAVE_INFO
}

GENERATE_RANDOM_NUMBER(){
  echo $((1 + RANDOM % 1000))
}

GET_USER_INFO(){
  echo -e "\nEnter your username:"
  read NAME

  if [[ ${#NAME} -gt 22 ]]; then
    echo "Username too long. Please enter a username that is 22 characters or less."
    return
  fi

  NAME_EXISTS=`$PSQL "SELECT EXISTS(SELECT 1 FROM users WHERE name = '$NAME')"`
  
  if [ $NAME_EXISTS = "f" ]; then
    echo "Welcome, $NAME! It looks like this is your first time here."
    INSERT_NAME=$($PSQL "INSERT INTO users(name) VALUES('$NAME')")
  else
    GAMES_PLAYED=`$PSQL "SELECT games_played FROM users WHERE name = '$NAME'"`
    BEST_GAME=`$PSQL "SELECT best_game FROM users WHERE name = '$NAME'"`
    echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
}

PLAY_GAME() {
  NUMBER_TO_GUESS=$1

  echo -e "\nGuess the secret number between 1 and 1000:"
  read NUMBER

  NUMBER_OF_GUESSES=1

  while [[ $NUMBER -ne $NUMBER_TO_GUESS ]]
  do
    if [[ ! "$NUMBER" =~ ^[0-9]+$ ]]; then
      echo -e "\nThat is not an integer, guess again:"
      read NUMBER
    elif [[ $NUMBER -lt $NUMBER_TO_GUESS ]]; then
      echo -e "\nIt's higher than that, guess again:"
      read NUMBER
    elif [[ $NUMBER -gt $NUMBER_TO_GUESS ]]; then
      echo -e "\nIt's lower than that, guess again:"
      read NUMBER
    fi
    NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
  done

  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $NUMBER_TO_GUESS. Nice job!"
}

SAVE_INFO() {
  UPDATE_GAME_PLAYED=$($PSQL "UPDATE users SET games_played = games_played+1 WHERE name = '$NAME';")
  CURRENT_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE name = '$NAME';")
  
  if [ "$CURRENT_BEST_GAME" -gt "$NUMBER_OF_GUESSES" ] || [ "$CURRENT_BEST_GAME" -eq 0 ]
  then
    UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game = $NUMBER_OF_GUESSES WHERE name = '$NAME';")
  fi
}


MAIN_MENU
