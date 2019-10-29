# Brainfuck

 - main.s:
    This file contains the main function.
    It reads a file from a command line argument and passes it to the brainfuck subroutine

 - read_file.s:
    Holds a subroutine for reading the contents of a file.
    This subroutine is used by the main function in main.s.

 - brainfuck.s:
    This interprets the brainfuck code

 - Makefile:
    A file containing compilation information.  
    
 - Example files:
    Multiple brainfuck programs you can use to test the workings of the interpreter 



Feel free to have a look at the different files, but keep in mind that all you need to do is:

  1. Edit `brainfuck.s`
  2. Run `make`
  3. Run `./brainfuck <filename>`

