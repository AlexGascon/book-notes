# Mastering Vim Quickly

## Introduction
![](cover.png)
Mastering Vim Quickly is a book from Jovica Ilic about the Vim text editor. It's structured as short chapters that present different Vim concepts in a way that makes it very easy to understand and to get familiar with it.

More information on https://jovicailic.org/mastering-vim-quickly/

## Chapter 5 - Vim Concepts
**Insert Normal mode**: It's like `Normal mode`, but it returns to `Insert mode` after executing a command. You can enter it by pressing `Ctrl-o` while on `Insert mode`

## Chapter 6 - Working with files
- `gf`: Opens a file whose filename is under the cursor
- `gx`: Opens the current link in your web browser
- `ZZ`: Equivalent to `:x`, but directly from your keyboard (`:x` closes a file and only writes if it has changed)
- `:r` or `:read`: Outputs the content of a file or command after the cursor
  - `:r file.txt` inserts file.txt below the cursor in the current buffer
  - `:r !ls` Inserts the output of `ls` below the cursor
  - `:r!sed -n 2,8p file.txt` inserts line 2 to 8 from the file below the cursor

Scrolling:
- `Ctrl-d`: Scroll down half page
- `Ctrl-u`: Scroll up half page
- `Ctrl-f`: Scroll down (**forwards**) full page
- `Ctrl-b`: Scroll up (**backwards**) full page

Jumping around:
- `{`: Beginning of the current paragraph
- `}`: End of the current paragraph
- `%`: Matching pair of `(), [], {}`
- `50%`: Go to the line at 50% of the file
- `:NUM`: Go to the line `NUM`
- `H`: Move cursor to the first (**highest**) line in the current window
- `L`: Same but to the last (**lowest**) line
- `M`: Same with the **middle** line
