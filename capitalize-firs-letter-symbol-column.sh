#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENTS_TABLE_QUERY_RESULT=$($PSQL "SELECT atomic_number, symbol FROM elements")

echo -e "$ELEMENTS_TABLE_QUERY_RESULT" | while IFS="|" read ATOMIC_NUMBER SYMBOL
do
  UPPERCASE_SYMBOL=$(echo $SYMBOL | sed -r 's/(^\w)/\U\1/')
  UPDATE_ELEMENTS_TABLE_RESULT=$($PSQL "UPDATE elements SET symbol='$UPPERCASE_SYMBOL' WHERE atomic_number=$ATOMIC_NUMBER")
  echo $UPDATE_ELEMENTS_TABLE_RESULT
done
