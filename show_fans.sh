#!/bin/bash


if ! test "$(ipmi-sensors 2>&1 | grep regenerate)" = ""
then
        ipmi-sensors --flush-cache
fi


ipmi-sensors | grep  "'OK'" | grep "Fan"
