#!/bin/bash

##### Leight of a string
string="Hello, world!"
echo ${#string}
echo `expr length $string`
echo `expr "$string" : '.*'`