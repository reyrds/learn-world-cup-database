#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" && $OPPONENT != "opponent" ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID_1=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $TEAM_ID && -z $TEAM_ID_1 ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER'), ('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 2" ]]
      then
        echo Inserted into teams, $WINNER
        echo Inserted into teams, $OPPONENT
      fi
    fi
  fi
#  if [[ -z $winner ]]
#  then
#    INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
#    if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
#      then
#        echo Inserted into majors, $MAJOR
#      fi
#  fi
done