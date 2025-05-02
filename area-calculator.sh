#!/bin/bash

type_text() {
    text=$1
    delay="${2:-0.05}"
    sound="${3:-type.mp3}"

    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        play -q "$sound" &
        sleep "$delay"
    done
    echo
}

type_text "What shape would you like to calculate the area of?"
read shape