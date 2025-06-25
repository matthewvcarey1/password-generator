#!/bin/sh

tmpfile=$(mktemp -u --suffix ".txt")
count=15

for i in $(seq $count); do
   /home/${USER}/bin/random_passwords.sh 3 >> $tmpfile;
done

kdialog --textbox $tmpfile --geometry 300x300+500+500 --title "possible passwords"

rm $tmpfile
