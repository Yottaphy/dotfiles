#!/bin/sh
#
#This script cleans the latex files that are generated during compilation. It will leave the .tex and .pdf files intact.

filename=$1

for i in {aux,bbl,blg,fdb_latexmk,fls,log,out,"synctex.gz"}
do
    rm ${filename}.${i}
done
