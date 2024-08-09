#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ELEMENTS_TABLE_QUERY_RESULT=$($PSQL "SELECT atomic_number, atomic_mass FROM properties")

echo -e "$ELEMENTS_TABLE_QUERY_RESULT" | while IFS="|" read ATOMIC_NUMBER ATOMIC_MASS
do
  TRIMMED_ATOMIC_MASS=$(echo "$ATOMIC_MASS" | sed -r 's/0+$//')
  UPDATE_PROPERTIES_RESULT=$($PSQL "UPDATE properties SET atomic_mass=$TRIMMED_ATOMIC_MASS WHERE atomic_number=$ATOMIC_NUMBER")
done
