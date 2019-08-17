# Part 3 - Patterns for TDD #
## Introduction ##
This section changes from the practical approach used in previous chapters to one more focused on theory, with the introduction and description of patterns that are useful in your day-to-day TDD journey

I won't document all of them (as it would require copying the book almost word by word), but instead I will publish some notes of the concepts I considered the most interesting. They are divided in several chapters, focusing on differents parts of the TDD process.

## Test-Driven Development Patterns ##
* Prepare the tests one by one, instead of trying to write all the tests first. Never be more than one change away from green. Otherwise, you'll have unnecessary stress and it will affect your ability to reason effectively.
* Assert first. The assertion is the most important part of the test, so by doing it first we start focusing on how we want it to look vs Where we're going to implement that functionality, how are we going to call the variables, etc

## Red bar patterns ##
* If you really don't know what to do (how to write that test, how to implement that feature, etc), take a break. Fatigue breaks your judgment, and you need to move away from it to keep being sharp

## Testing patterns ##
* **Child test**: When trying to test something and ending with a test that is too big, write a smaller test representing the broken version of the big test, make it pass, and then introduce the larger test case again

* **Broken test**: After finishing a programming session, if you're programming alone, leave your last test broken. That way, when you go back to the code, you know exactly what where you doing: implementing the feature with the broken test. This will let you avoid spending time trying to remember where you were, what you were trying to achieve, etc. *Note: do this only when you're working alone in your project. DON'T do this on a team project, as you will leave the environment broken for everyone else and that's very rude*

## Green bar patterns ##
* **Fake It 'til you make it):** Your first implementation to fix a broken test should be returning a constant to make the test pass. That way, you will know that the test can work, and that you only need to work on making the implementation work for your actual use case. Also, it helps psychologically: knowing that you are in a "green" state makes you feel better than being on a "red" state

* **Triangulate:** Abstract only when you have two test cases that require the same logic. If you try to make your code more abstract but you only have one use case, maybe you are optimizing too soon.
