# Part 2 #
## Introduction ##
In this second part of the book, we focus on learning more about the xUnit architecture. This architecture gets is name from a set of unit testing frameworks that derive their structure and functionality from Smalltalk SUnit, which was created by Kent Beck (yes, the author of the TDD by example book). Some examples of these frameworks are JUnit for Java or RUnit for R.

### xUnit ###
The xUnit architecture is composed of the following elements:
* **Test runner**: an executable program that runs tests and reports its results
* **Test case**: the most elemental class, from which all unit tests inherit
* **Test fixture**: the set of preconditions or state needed to run a test. They should be set prior to the test execution, and be completely removed after it to avoid interfering with other tests.
* **Test suite**: a set of tests that share the same fixture

In xUnit, the tests execution is divided in three steps:
* **Setup**: where we prepare the test environment (e.g. we create the fixtures, or make sure that the context is clean)
* **Test**: the test itself
* **Teardown**: where we clean the environment and return everything to the state it was prior to the test execution.

### This section ###
In order to learn more about xUnit, we're going to create our own test framework. At the beginning it will be a bit strange, because of course we're going to use TDD, and therefore it means that we will be testing a test framework with our own test framework, but as we advance everything will start coming into place.

Also, in this section we'll change the programming language from Java to Python, as its syntax makes a bit more simple to develop this project.
