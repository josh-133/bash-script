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

read_number() {
    local prompt=$1
    local var
    while true; do
        type_text "$prompt" 0.08
        read var
        if [[ "$var" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
            number_result="$var"
            return
        else
            type_text "Please enter a valid number: " 0.08
        fi
    done
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
        read_number "Enter the base/length:"
        length=$number_result
        read_number "Enter the height/width:"
        width=$number_result
        calculate_area "$shape" "$length" "$width"
        ;;
    square)
        read_number "Enter the length of one side:"
        length=$number_result
        calculate_area "$shape" "$length"
        ;;
    circle)
        read_number "Enter the radius:"
        radius=$number_result
        calculate_area "$shape" "$radius"
        ;;
    *)
        type_text "Unknown shape $shape" 0.08
        ;;
esac