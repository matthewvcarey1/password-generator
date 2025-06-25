#!/bin/bash

# Random Password Generator  
# Cribbed from code at linuxconfig.org 
 
if [ $# -ne 1 ] 
then 
echo "Please specify how many random words would you like to generate !" 1>&2 
echo "example: ./random-password-generator 3" 1>&2 
echo "This will a generate a password containing 3 random words" 1>&2 
exit 0
fi 
 
# Constants 
X=0
ALL_NON_RANDOM_WORDS=/usr/share/dict/words
 
# total number of non-random words available 
non_random_words=`cat $ALL_NON_RANDOM_WORDS | wc -l` 
 
# while loop to generate random words  
# number of random generated words depends on supplied argument 
dash="-"
last=$(($1 - 1))
while [ "$X" -lt "$1" ] 
do
  # Generate a random number in the correct range	
  random_number=`od -N3 -An -i /dev/urandom | 
     awk -v f=0 -v r="$non_random_words" '{printf "%i\n", f + r * $1 / 16777216}'`
  # Pull the random word out of the dictionary
  word=$(sed  $(echo  $random_number)"q;d" $ALL_NON_RANDOM_WORDS | tr -d '\n')

  # We skip words greater than 6 characters or less than 4 characters
  # and words with numbers in them
  if [[ ${#word} -ge 7 ]] || [[ ${#word} -le 3 ]] || [[ $word =~ [^a-zA-Z0-9] ]]  ; then
      continue   
  fi
  # We put dashes between words
  if [ $X -eq $last ]; then dash=""; fi
  echo -n ${word}${dash} 
  let "X = X + 1"
done
echo

