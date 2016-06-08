#!/usr/bin/env sh
# ===========================================================================
# Program: b - backup files passed as arguments or current directory without args
#    Desc: Backup a File in ../.backup dir w/timestamp.
#   Notes: You should use git or another source code control system instead
#          but this program is for when you need a quick file backup
#          instead of manually backing up the file with cp continuously.
#  Author: Joe Orzehoski
#    Date: 6/1/2014
#      OS: Works on mac and hpux operating systems.
# ===========================================================================

  # Make the backup directory up one and down in case someone does rm -rf .
  PWD=`pwd`
 RDIR=`basename "$PWD"`
 BDIR="../.backup/$RDIR"
  DIR="$PWD"
  PRG=`basename $0`
  day=`date +%d`;
month=`date +%b`;
 year=`date +%Y`;
 hour=`date +%H`;
  min=`date +%M`;
  sec=`date +%S`;
 DATE="${day}-${month}-${year}_${hour}:${min}:${sec}"; # Date string

# --------------------------------------------------------------------------
# Set usage message

USAGE="$PRG - backup files to ../.backup directory w/timestamp name
Usage: $PRG [-h] [file1 file2 ...]
   Ex: $PRG ............... backups default files in var FILE in $PRG"

# --------------------------------------------------------------------------
# Process commandline arguments

while [ $# -ne 0 ]; do
  case $1 in
    -h) echo "$USAGE"
        exit 0
    ;;
    *) FILES="${FILES:+$FILES }$1"
       shift
    ;;
  esac
done

if [ `echo $FILES | grep -c "." 2>/dev/null` -eq 0 ] ; then
 	# -------------------------------
 	# FILES is empty so take current directory
	FILES=`find . -type f -maxdepth 1`
fi

# --------------------------------------------------------------------------
# Create the backup dir if not already present

cd "$DIR"
if [ ! -d "$BDIR" ]; then mkdir -p "$BDIR"; fi

# --------------------------------------------------------------------------
# Backup each file w/time stamp as name

for file in `echo $FILES`
do
  if [ -f $file ]; then
    echo "Run: cp $file $BDIR/${file}_${DATE}"
    cp $file "$BDIR/${file}_${DATE}"
  fi
done
