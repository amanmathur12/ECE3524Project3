#!/bin/sh

echo "<!DOCTYPE html>">filetree
echo "<!body>">>filetree
echo "<h2>Directory Tree from Home</h2>">>filetree

for i in $(find .. -mindepth 1 -maxdepth 1 -type d);
do
    echo "<ul>">>filetree
    if [ ! -r $i ]; then
    	echo "file/directory not readable"
    	exit
    fi
    echo "<li>${i##*/}">>filetree
    
    for j in $(find $i -mindepth 1 -type d);
    do
    	if [ ! -r $j ]; then
    		echo "file/directory not readable"
        fi
        
    	echo "<ul>">>filetree
    	echo "<li>${j##*/}">>filetree
    	echo "<ul>">>filetree
    	
    	for k in $(find $j -mindepth 1 -maxdepth 1 -type f);
    	do
    		if [ ! -r $k ]; then
    			echo "file/directory not readable"
    		fi
    		
    		echo "<li>${k##*/}</li>">>filetree
    	done
    	
    	echo "</ul>">>filetree
    	echo "</li>">>filetree
    	echo "</ul>">>filetree
    done
    
    echo "</li>">>filetree
    echo "</ul>">>filetree

done

