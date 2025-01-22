import random, strutils

randomize()

let secret = rand(100) + 1
var guess: int

echo "Welcome to the Number Guessing Game"
echo "Guess a number 1 to 100"

while true:
    echo "Enter your guess: "
    let input = readLine(stdin)
  
    try:
        guess = parseInt(input)
    except ValueError:
        echo "Number invalid"
        continue

    if guess < secret:
        echo "Higher!"
    elif guess > secret:
        echo "Lower!"
    else:
        echo "You win"
        break
