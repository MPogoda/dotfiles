#!/bin/sh

while true
do
	mpc idle
  sleep 10
  mpc --format "%title%\n%artist%\n%album%\n%track%\n%time%" | head -n -2 > ~/.psi/tune
done
