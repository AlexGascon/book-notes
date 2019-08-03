# Part 1 - The Money Example #
## Introduction ##
The goal of this first part is to serve as an introduction to TDD. While we'll be developing a system (a kind-of wallet that lets us hold different currencies and do operations with them), the goal **is not what** we're developing, **but how** we're doing it: by using the TDD process:
	1. Add a test that uses the interface that you want to end with
	2. Run the test suite and see it fail
	3. Implement the changes that are needed to make the test pass
	4. Run the test suite again, and see it work
	5. Refactor your implementation (not your test) to make the code better
	6. Go back to step 4 until you are completely happy with your implementation

One of the key details of TDD is on the step 3: it specifies that you need to make changes to make the test pass, but now how those changes should be: whatever works if we get to our goal (one common situation is to simply fake the implementation, forcing it to return that our test will be expecting). And while that may seem an incredibly bad solution, it's actually one of the benefits of TDD: once you have implemented something that passes all your tests, you know that you can reach the point where your code achieves the behavior that you want it to. Therefore, now it's time to refactor the code and make it actually useful, with the confidence that no matter what changes you make, if your test suite passes is because your changes work.

Unfortunately you won't be able to fully appreciate the TDD process just by reading the codebase, because you'll only see the end product. However, if you have in mind that the test is the first code that was written in each chapter, and see which changes were implemented as a result of it, you will at least get a grasp of how we've taken advantage of TDD, implementing more and more changes chapter by chapter but without forgetting of our original behavior.

## Conclusion ##
(Come back to this part after having observed all the codebase)

And here is where our money journey ends. Is this a final product? Obviously not: there are still a lot of details that need to be implemented (floating-point operations, for example), and that are key if we want to have a real money-management system. However, remember what we mentioned on the introduction: it's not the goal of this part to end with a perfect product, but to let the reader get hands-on experience with TDD. 

If you want to dive deeper, you can always follow the same methodology to implement some of those changes that are missing, or even to introduce new features on your own. 

And, as a personal note, I wanted to stress out the learning that has been more important for me in this part of the book: TDD is not about being forced to make small steps, but to start with a tiny step, check that everything is fine, and from that point having the freedom to choose what size do you want your steps to be. 
