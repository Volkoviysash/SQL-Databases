#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

SERVICE_MENU() {
  SERVICE_LIST=$($PSQL "SELECT name FROM services")
  echo -e $SERVICE_LIST
}

SERVICE_MENU
