# Tetris Compiler

## How to Run

1. Make sure you have `Flex` and `Bison` installed.
2. Open a terminal and navigate to the directory containing the source files.
3. Type `make` to compile the compiler.
4. After successful compilation, run the compiler by typing `./tetris`.
5. We have provided 2 testcases in the files named 'testinput.tetris' and 'test2.tetris' which display various inputs given to the compiler.

## Semantics

This Tetris compiler allows game programmers to define various features of the Tetris game. Here are the available features and their corresponding commands:

1. **Forward Color (`fg`):** Sets the color of the Tetris blocks.
* color specification for foreward color: - (Put these integers for respective colors in play call in Section 3 ) 
'black'=0
'red'=1
'green'=2 
'blue'=3
'cyan'=4
'yellow'=5 
'magenta'=6 
2. **Background Color (`bg`):** Sets the background color of the Tetris game.
Background color specifications are as follows: 
'light gray'=0,'white'=1, 'black'=2
3. **See Next Tetromino (`show_next`):** Displays the next Tetris piece that will appear.

4. **Difficulty Level (`difficulty`):** Sets the difficulty level of the game.
5. **Speed Increase Factor (`speed_increase_factor`):** Adjusts the speed at which the Tetris pieces fall.
6. **Height (`height`):** Sets the height of the Tetris game board.
7. **Width (`width`):** Sets the width of the Tetris game board.
8. **Distribution (`dist`):** Sets the probability distribution of Tetris pieces.
For using various distributiions: 
 1. dist=0: Random
 2. dist=1: Normal
 3. dist=2: Uniform
 4. dist=3 Gamma 
9. ** Rotation of tetrominos ** follow following specification (`direction`)
  a. 'LEFT'=1
  b. 'UP'=1
  c. 'RIGHT'=2
  d. 'DOWN'=3

---
# Tetris Script

Tetris Script is a domain-specific language designed for programming Tetris game behaviors and configurations.

## Overview

Tetris Script allows game programmers to define various aspects of the Tetris game, including primitives, functions, and engine configurations.

## Syntax
Each new line of the script must be seperated by '#'.

### Sections

A Tetris Script program consists of three main sections:

1. **Section 1:** Primitive Declarations
2. **Section 2:** Function Definitions
3. **Section 3:** Engine Configuration

Each section is delineated by a keyword followed by a newline.

#### Section 1: Primitive Declarations

In this section, you can define primitive variables and their initial values.

Example:
```
score = 0
speed = 1.5
```

#### Section 2: Function Definitions
User must provide a function named 'mainFunc' which is the starting point of the execution of code.
Functions in Tetris Script are defined with the following syntax:

```
{ function_name statement1 statement2 ... }
```

Example:
```
{Func3 while( 3 + 5 ) while( 3+ 5 )Someothername=5 end end}
#
{ mainFunc show_next = 1 }
```

#### Section 3: Engine Configuration

This section configures the Tetris game engine, including the main function and any additional setup.

Example:
```
[ play with difficulty=difficulty fg=fg_color show_next=show_next]
```

### Statements

Tetris Script supports various statements within function bodies, including:

- **Assignment:** Assigning values to variables.
- **Control Flow:** `if`, `then`, `else`, `end`, `while` statements for conditional and loop execution.
- **Function Calls:** Calling defined functions.

### Keywords

Tetris Script reserves keywords for language constructs:

- `if`, `then`, `else`, `end`, `while`: Control flow keywords.
- `call`, `with`: Function call and parameter passing keywords.
- `or`, `and`, `not`: Logical operators.
- `neg`: Negation operator.
- `play`: Engine configuration keyword.

### Identifiers

Identifiers are used to name variables and functions. They must start with a letter and can contain letters, digits, and underscores.

### Numbers

Tetris Script supports integer and floating-point numbers.

## Example Program

```
Section1
#
Somename = 0
#
Someothername = 1
#
difficulty=1
#
fg_color=1
#
bg_color=5
#
speed_increase_factor=1
#
speed_decrease_factor=1
#
difficulty=1
#
show_next=0
#
Section2
#
{ mainFunc show_next = 1 }
#
Section3
#
[ play with difficulty=difficulty fg=fg_color show_next=show_next]

```

## Conclusion

This README provides an overview of Tetris Script syntax and structure. With this knowledge, you can start writing and experimenting with Tetris game behaviors and configurations using Tetris Script.

