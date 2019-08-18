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

## Refactoring ##
* **Isolate change:** To change one part of a method or object, start by isolating that part (there are several ways to do this: Extract Method, Extract Object, Method Object... but that's out of the scope of this pattern). Think of the isolation as a surgery: you're getting surgery for a very specific purpose. Yes, maybe you could get more things fixed now that you're on it; but honestly, I'm glad that the doctor is focusing on just one thing.

## Mastering TDD ##
*Note: this entire chapter is really good, if you have access to the book is worth reading it entirely. But as I feel good duplicating all the chapter in this markdown file, I'm just going to highlight a few points. But seriously, all of it is really good, read it.*

* **How do you know if you have good tests?**: (I'm keeping this title because it's the one that is specified on the book, but a much better title is "How your tests can tell you if your code has good design")
	* Long setup code - If you have to prepare a lot of objects for your test to work, maybe your objects are too big and you need to split them
	* Setup duplication - If you can't easily find a common place for common setup code, there are many objects too tightly intertwined

* **How do you switch to TDD midstream?**: Start adding tests to the existing code, and from there start refactoring. However, adding tests to the entire codebase may be a process that lasts for a long period of time. Therefore, the best option is to delimit a scope of the things that is more important to refactor, and do the full cycle (add tests + refactor + keep working but now with TDD) on that scope. This means that if there is code that can be greatly refactored, but it's code that doesn't demand any change for the moment, just leave it as it is.

* **How does TDD relate to eXtreme Programming practices?**:
	* Pairing: The tests you right in TDD are a good conversation when pairing. Also, the fact that you start defining the interface that your code will have is good because you start by discussing the design with your pair.
	* Work fresh: XP advises to work when you are fresh and sharp, and rest when not. If you feel that it's taking too much effort to write your tests or to remove duplication after getting them to green, take a break and come back later.
	* Continuous integration: the more tests you have, the easier it will be to integrate
	* Simple design: as you start with the bare minimum to make your tests pass, and then you only refactor to make more tests pass, you get the minimum design that matches all the features you expect.
	* Refactoring: Pretty obvious - You refactor your implementation to get more and more tests to pass, and to remove duplication or "fakes" on it.
	* Continuous delivery: related with Continuous integration - the easier to integrate, the easier to delivery
