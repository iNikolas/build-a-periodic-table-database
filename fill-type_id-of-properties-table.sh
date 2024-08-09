#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ALL_TYPES_QUERY_RESULT=$($PSQL "SELECT type_id, type FROM types")

ALL_PROPERTIES_QUERY_RESULT=$($PSQL "SELECT atomic_number, type FROM properties")

echo -e "$ALL_PROPERTIES_QUERY_RESULT" | while IFS="|" read ATOMIC_NUMBER TYPE
do
  echo -e "$ALL_TYPES_QUERY_RESULT" | while IFS="|" read TYPE_ID TYPE_NAME
  do
    if [[ $TYPE == $TYPE_NAME ]]
    then
      INSERT_TYPE_ID_RESULT=$($PSQL "UPDATE properties SET type_id=$TYPE_ID WHERE atomic_number=$ATOMIC_NUMBER")
    fi
  done
done
