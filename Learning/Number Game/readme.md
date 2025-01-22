# Number Guessing Game

This is a simple command-line number guessing game written in Nim. The program generates a random number between 1 and 100, and the player tries to guess it. After each guess, the program provides feedback to help the player narrow down the correct number.

## How to Run
1. Make sure you have Nim installed on your system. You can download it from [Nim's official website](https://nim-lang.org/).
2. Save the program in a file, e.g., `guessing_game.nim`.
3. Open a terminal and navigate to the directory containing the file.
4. Compile the program using the Nim compiler:
   ```bash
   nim c -r guessing_game.nim
   ```

## Gameplay Instructions
1. Run the program. It will greet you with a welcome message and prompt you to guess a number.
2. Enter your guess when prompted.
3. The program will provide feedback:
   - **"Higher!"** if your guess is too low.
   - **"Lower!"** if your guess is too high.
   - **"You win"** if you guess the correct number.
4. The game ends when you guess the correct number.

## Error Handling
- If you input a value that is not a valid integer, the program will notify you with the message:
  ```plaintext
  Number invalid
  ```
  It will then prompt you to try again.

## Example Gameplay
```plaintext
Welcome to the Number Guessing Game
Guess a number 1 to 100
Enter your guess: 
50
Higher!
Enter your guess: 
75
Lower!
Enter your guess: 
63
You win
```

---

This readme was rewritten for clarity by AI.
