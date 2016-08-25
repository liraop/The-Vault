#!/bin/bash


curl -vsI www.google.com | grep -oh "[0-2][0-9]:[0-5][0-9]:[0-5][0-9]"
