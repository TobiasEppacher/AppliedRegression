#!/bin/sh
mkdir -p docs
pandoc -V documentclass=report -V classoption=oneside -V geometry:vmargin=14.5mm -V lang:de --output=docs/merge.pdf md/*.md