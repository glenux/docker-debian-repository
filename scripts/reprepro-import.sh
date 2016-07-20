#!/bin/sh

BASEDIR=/var/lib/reprepro
INCOMING=/docker/incoming
OUTDIR=/repository/debian

#
# Make sure we're in the apt/ directory
#
cd $INCOMING
cd ..

#set -x
reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks stable
reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks jessie
reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks unstable
reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks sid
#
#  See if we found any new packages
#
found=0
for i in $INCOMING/*.changes; do
  if [ -e $i ]; then
    found=`expr $found + 1`
  fi
done
#
#  If we found none then exit
#
if [ "$found" -lt 1 ]; then
   exit
fi


#
#  Now import each new package that we *did* find
#
for i in $INCOMING/*.changes; do

  # Import package to 'sarge' distribution.
  reprepro -V --basedir $BASEDIR \
          --keepunreferencedfiles \
          --outdir $OUTDIR include unstable $i

  # Delete the referenced files
  sed '1,/Files:/d' $i | sed '/BEGIN PGP SIGNATURE/,$d' \
       | while read MD SIZE SECTION PRIORITY NAME; do
        
      if [ -z "$NAME" ]; then
           continue
      fi


      #
      #  Delete the referenced file
      #
      if [ -f "$INCOMING/$NAME" ]; then
          rm "$INCOMING/$NAME"  || exit 1
      fi
  done

  # Finally delete the .changes file itself.
  rm  $i
done
chown -R www-data:www-data $OUTDIR
