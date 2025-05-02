#!/bin/bash
# MATHS TOOL SUITE WITH THE FOLLOWING FEATURES
# Calculating PERIMETER, AREA & VOLUME for:
#       - Rectangles
#       - Squares
#       - Triangles
#       - Circles/Spheres

# makes text look like its being typed with an added sound effect
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
        type_text "$prompt"
        read var
        if [[ "$var" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
            number_result="$var"
            return
        else
            type_text "Please enter a valid number: " 
        fi
    done
}

calculate_perimeter() {
    case $1 in
        rectangle)
            perimeter=$(echo "$2 * 2 + $3 * 2" | bc)
            ;;
        square)
            perimeter=$(echo "$2 * 4" | bc)
            ;;
        triangle)
            perimeter=$(echo "$2 + $3 + $4" | bc)
            ;;
        circle)
            perimeter=$(echo "2 * 3.14159 * $2" | bc)
            ;;
        *)
            type_text "Sorry I don't know how to calculate the perimeter of $1." 
            return
            ;;
    esac

    type_text "The perimeter of the $1 is $perimeter units." 
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
            type_text "Sorry I don't know how to calculate the area of $1." 
            return
            ;;
    esac

    type_text "The area of the $1 is $area units squared." 
}

calculate_volume() {
    case $1 in
        rectangle)
            volume=$(echo "$2 * $3 * $4" | bc)
            ;;
        square)
            volume=$(echo "$2 * $2 * $2" | bc)
            ;;
        triangle)
            volume=$(echo "0.5 * $2 * $3 * $4" | bc)
            ;;
        sphere)
            volume=$(echo "4 * 3.14159 * $2 * $2 * $2" | bc)
            ;;
        *)
            type_text "Sorry I don't know how to calculate the volume of $1." 
            return
            ;;
    esac

    type_text "The volume of the $1 is $volume units cubed." 
}

# Beginning of program
type_text "WELCOME TO THE MATHS TOOL SUITE"
type_text "Would you like to calculate perimeter, area, or volume? (select 1, 2, or 3)"
read option

if [[ $option == 1 ]]; then
    type_text "What shape would you like to calculate the perimeter of?" 0.05
elif [[ $option == 2 ]]; then
    type_text "What shape would you like to calculate the area of?" 0.05
elif [[ $option == 3 ]]; then
    type_text "What shape would you like to calculate the volume of?" 0.05
else
    type_text "Please enter either '1', '2', or '3' next time"
    exit 1
fi

read shape

case $shape in
    rectangle|triangle)
        read_number "Enter the base/length:"
        length=$number_result
        read_number "Enter the height/width:"
        width=$number_result

        if [[ $option == 1 && $shape == "rectangle" ]]; then
            calculate_perimeter "$shape" "$length" "$width"
        elif [[ $option == 1 && $shape == "triangle" ]]; then
            read_number "Enter the length of the third side:"
            3rd_side=$number_result
            calculate_perimeter "$shape" "$length" "$width" "$3rd_side"
        elif [[ $option == 2 ]]; then
            calculate_area "$shape" "$length" "$width"
        elif [[ $option == 3 ]]; then
            read_number "Enter the depth:"
            depth=$number_result
            calculate_volume "$shape" "$length" "$width" "$depth"
        fi
        ;;
    square)
        read_number "Enter the length of one side:"
        length=$number_result

        if [[ $option == 1 ]]; then
            calculate_perimeter "$shape" "$length"
        elif [[ $option == 2 ]]; then
            calculate_area "$shape" "$length"
        elif [[ $option == 3 ]]; then
            calculate_volume "$shape" "$length"
        fi
        ;;
    circle|sphere)
        read_number "Enter the radius:"
        radius=$number_result

        if [[ $option == 1 ]]; then
            calculate_perimeter "$shape" "$radius"
        elif [[ $option == 2 ]]; then
            calculate_area "$shape" "$radius"
        elif [[ $option == 3 ]]; then
            calculate_volume "$shape" "$radius"
        fi
        ;;
    *)
        type_text "Unknown shape $shape" 
        ;;
esac