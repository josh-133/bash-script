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

calculate_area() {
    case $1 in
        rectangle)
            area=$(echo "$2 * $3" | bc)
            ;;
        square)
            area=$(echo "$2 * $2" | bc)
            ;;
        triangle)
            area=$(echo "0.5 * $2 * $3" | bc)
            ;;
        circle)
            area=$(echo "3.14159 * $2 * $2" | bc)
            ;;
        *)
            type_text "Sorry I don't know how to calculate the area of $1." 0.08
            return
            ;;
    esac

    type_text "The area of the $1 is $area units." 0.08
}

type_text "What shape would you like to calculate the area of?" 0.08
read shape

shape=$(echo "$shape" | tr '[:upper]' '[:lower]')

case $shape in
    rectangle|triangle)
        type_text "Enter the base/length" 0.08
        read length
        type_text "Enter the height/width" 0.08
        read width
        calculate_area "$shape" "$length" "$width"
        ;;
    square)
        type_text "Enter the length of one side" 0.08
        read length
        calculate_area "$shape" "$length"
        ;;
    circle)
        type_text "Enter the radius" 0.08
        read radius
        calculate_area "$shape" "$radius"
        ;;
    *)
        type_text "Unknown shape $shape" 0.08
        ;;
esac