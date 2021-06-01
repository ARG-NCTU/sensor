#! /bin/bash

current_path=$(pwd)
BRANCH=master
if [ ! -z "$1" ]; then
    echo "pull branch: $1"
    BRANCH=$1
fi

echo "-----------------------------------------------------------------------"
echo "-------------------------pull sensor ----------------------------------"
echo "-----------------------------------------------------------------------"
git pull

CONFLICTS=$(git ls-files -u | wc -l)
if [ "$CONFLICTS" -gt 0 ] ; then
   echo "There is conflict in mm-dual-arm-regrasp. Aborting"
   return 1
fi

BRANCH=indigo-devel

echo "-----------------------------------------------------------------------"
echo "-------------------------pull apriltags -------------------------------"
echo "-----------------------------------------------------------------------"
cd $current_path/apriltags
git checkout $BRANCH
git pull

CONFLICTS=$(git ls-files -u | wc -l)
if [ "$CONFLICTS" -gt 0 ] ; then
   echo "There is conflict in apriltags. Aborting"
   return 1
fi

BRANCH=2.3.0

echo "-----------------------------------------------------------------------"
echo "-------------------------pull realsense -------------------------------"
echo "-----------------------------------------------------------------------"
cd $current_path/realsense
git checkout $BRANCH
git pull

CONFLICTS=$(git ls-files -u | wc -l)
if [ "$CONFLICTS" -gt 0 ] ; then
   echo "There is conflict in pyrobot. Aborting"
   return 1
fi

cd $current_path
return 0
