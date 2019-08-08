from tdd.test_case import TestCase
from tdd.test_result import TestResult
from tdd.test_suite import TestSuite
from tdd.was_run import WasRun


class TestCaseTest(TestCase):
    def test_template_method(self):
        test = WasRun("test_method")
        test.run()
        assert("set_up test_method tear_down " == test.log)
 
    def test_result(self):
        test = WasRun("test_method")
        result = test.run()
        assert("1 run, 0 failed" == result.summary())

    def test_failed_result(self):
        test = WasRun("test_broken_method")
        result = test.run()
        assert("1 run, 1 failed" == result.summary())

    def test_failed_result_formatting(self):
        result = TestResult()
        result.test_started()
        result.test_failed()
        assert("1 run, 1 failed" == result.summary())

    def test_suite(self):
        suite = TestSuite()
        suite.add(WasRun("test_method"))
        suite.add(WasRun("test_broken_method"))
        result = suite.run()
        assert("2 run, 1 failed" == result.summary())

print(TestCaseTest("test_template_method").run().summary())
print(TestCaseTest("test_result").run().summary())
print(TestCaseTest("test_failed_result").run().summary())
print(TestCaseTest("test_failed_result_formatting").run().summary())
print(TestCaseTest("test_suite").run().summary())
