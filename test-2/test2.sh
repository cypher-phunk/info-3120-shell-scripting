#!/bin/bash

P1="Hello      world   I        am       here"
P1=`echo "$P1" | tr '\t' ' ' | sed -e 's/[ ]//g'`
echo "$P1"

TESTME="0123456789"
echo "$TESTME" | wc -c

STREET="59 Lowes Way"

CITY="Lowell"

STATE="MA"

ADDRESS='$STREET

$CITY, $STATE'

echo "$ADDRESS"

MYVAR="This is a test"
echo "$MYVAR" | sed -e 's/.*\(.\)$/\1/'

STREET="1 University Ave" 	 
CITY="Lowell" 	 
STATE="MA" 	 
ADDRESS="$STREET
$CITY, $STATE"

echo '$ADDRESS'
echo "$ADDRESS"
echo $ADDRESS