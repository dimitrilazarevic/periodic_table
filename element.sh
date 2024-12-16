PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ ! $1 ]]

  then
  echo -e "Please provide an element as an argument."

  else
  
  if [[ $1 =~ [0-9]+ ]]

    then
    ATOM_INFO=$($PSQL "SELECT DISTINCT * FROM elements 
                       FULL JOIN properties 
                       USING (atomic_number) 
                       FULL JOIN types USING (type_id)
                       WHERE elements.atomic_number = $1
    ")

    else
    ATOM_INFO=$($PSQL "SELECT DISTINCT * FROM elements 
                       FULL JOIN properties 
                       USING (atomic_number) 
                       FULL JOIN types USING (type_id)
                       WHERE elements.symbol = '$1'
                       OR elements.name = '$1'
    
    ")

  fi

  if [[ -z $ATOM_INFO ]]

    then

    echo I could not find that element in the database.

    else

    echo "$ATOM_INFO" | (IFS="|" ; read BLANK ATOMIC_NUMBER SYMBOL NAME MASS MELTTEMP BOILTEMP TYPE ;
    echo -e "The element with atomic number "$ATOMIC_NUMBER" is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTTEMP celsius and a boiling point of $BOILTEMP celsius.")

  fi
fi
