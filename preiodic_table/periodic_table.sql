#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_MENU(){
  if [[ "$1" =~ ^[0-9]+$ ]]
    then
    GET_INFO_BY_ATOMIC_NUMBER $1
  elif [[ "$1" =~ ^[a-zA-Z]{1,2}$ ]]
    then
    GET_INFO_BY_SYMBOL $1
  elif [[ "$1" =~ ^[a-zA-Z]+$ ]]
    then
    GET_INFO_BY_NAME $1
  else
    echo "Error! Use ./element.sh 123 or ./element.sh H or ./element.sh Helium "
  fi
}

GET_INFO_BY_ATOMIC_NUMBER(){
  ATOMIC_NUMBER=$1
  ELEMENT_EXISTS=$($PSQL "SELECT EXISTS(SELECT 1 FROM elements WHERE atomic_number = $ATOMIC_NUMBER)")

  if [ $ELEMENT_EXISTS = "f" ]
  then
    echo "I could not find that element in the database."
    return
  fi

  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT types.type FROM properties JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number = $ATOMIC_NUMBER;")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

  PRINT_INFO $ATOMIC_NUMBER $NAME $SYMBOL $TYPE $ATOMIC_MASS $MELTING_POINT $BOILING_POINT_CELSIUS
}

GET_INFO_BY_SYMBOL(){
  SYMBOL=$1
  ELEMENT_EXISTS=$($PSQL "SELECT EXISTS(SELECT 1 FROM elements WHERE symbol = '$SYMBOL')")

  if [ $ELEMENT_EXISTS = "f" ]
  then
    echo "I could not find that element in the database."
    return
  fi
  
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
  TYPE=$($PSQL "SELECT types.type FROM properties JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number = $ATOMIC_NUMBER;")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

  PRINT_INFO $ATOMIC_NUMBER $NAME $SYMBOL $TYPE $ATOMIC_MASS $MELTING_POINT $BOILING_POINT_CELSIUS
}

GET_INFO_BY_NAME(){
  NAME=$1
  ELEMENT_EXISTS=$($PSQL "SELECT EXISTS(SELECT 1 FROM elements WHERE name = '$NAME')")

  if [ $ELEMENT_EXISTS = "f" ]
  then
    echo "I could not find that element in the database."
    return
  fi
  
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$NAME'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT types.type FROM properties JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number = $ATOMIC_NUMBER;")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

  PRINT_INFO $ATOMIC_NUMBER $NAME $SYMBOL $TYPE $ATOMIC_MASS $MELTING_POINT $BOILING_POINT_CELSIUS
}

PRINT_INFO() {
  ATOMIC_NUMBER=$(echo $1 | tr -d '[:space:]')
  NAME=$(echo $2 | tr -d '[:space:]')
  SYMBOL=$(echo $3 | tr -d '[:space:]')
  TYPE=$(echo $4 | tr -d '[:space:]')
  ATOMIC_MASS=$(echo $5 | tr -d '[:space:]')
  MELTING_POINT=$(echo $6 | tr -d '[:space:]')
  BOILING_POINT_CELSIUS=$(echo $7 | tr -d '[:space:]')

  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
}

if [ $# -eq 0 ]
  then
  echo "Please provide an element as an argument."
else
  MAIN_MENU $1
fi
