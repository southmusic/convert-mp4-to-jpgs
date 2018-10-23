#!/bin/bash 
# By Thomas Stevens 
# Filename: convert.sh 
# Converts all mp4 files in current directory to a series of optimized jpg images
# Requirements: 
# ffmpeg; ImageMagick
# run chmod u+x convert.sh before first run
# run by typing ./convert.sh at the prompt
#--------------------------------------------------------------------------------#
# CREATE ARRAY OF ALL MP4 FILES IN CURRENT DIRECTORY
current_directory=$(pwd)
mp4_files=$(find "${current_directory}" -type f -iname "*.mp4") 
# BEGIN MOVIE TO IMAGE CONVERSION
for mp4_file in ${mp4_files}; 
# REMOVE EXTENSION FROM VIDEO FILE NAME
do NAME=$(echo "$mp4_file" | cut -d'.' -f1);
# CONVERT MP4 FILES TO A SET OF IMAGES AND ADDS UNDERSCORE AND 2 DIGITS
ffmpeg -i ${mp4_file} -r 7 ${NAME}_%02d.png;
done
# CREATE VARIABLE FOR PNG FILES
png_files=$(find "${current_directory}" -type f -iname "*.png")

# CROP PNG FILES
#for png_file in $png_files;
#do convert ${png_file} -crop 480x480+80+0 ${png_file}
#done
# CONVERT TO JPG

for png_file in $png_files;
# REMOVE EXTENSION FORM PNG FILE
do FILENAME=$(echo "$png_file" | cut -d'.' -f1);
convert -strip -interlace Plane -quality 90 ${FILENAME}.png ${FILENAME}.jpg
done
# DELETE PNG FILES
rm *.png