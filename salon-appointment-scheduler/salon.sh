#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICE_MENU  
}

SERVICE_MENU() {
  SERVICE_LIST=$($PSQL "SELECT service_id, name FROM services")
    
  if [[ -z $SERVICE_LIST ]]
  then
    # send to main menu
    MAIN_MENU "Sorry, we don't have any services available right now."
  fi

  echo -e "\nHere are services available"
  echo "$SERVICE_LIST" | while read SERVICE_ID BAR SERVICE
  do
    echo "$SERVICE_ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
    MAIN_MENU "That is not a number"
  else
    SERVICE_AVAILABLE=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    if [[ -z $SERVICE_AVAILABLE ]]
      then
      MAIN_MENU "There is no such number"
      else
      SERVICE_BOOKING "$SERVICE_ID_SELECTED"
    fi
  fi
}

SERVICE_BOOKING() {
  SERVICE_ID_SELECTED=$1

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  
  echo -e "\nWhat time to sign up you for, $CUSTOMER_NAME?"
  read SERVICE_TIME
}

MAIN_MENU
