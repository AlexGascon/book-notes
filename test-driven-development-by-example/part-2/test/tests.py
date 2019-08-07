from tdd.test_case import TestCase
from tdd.was_run import WasRun


class TestCaseTest(TestCase):
    def test_running(self):
        test = WasRun("test_method")
        test.run()
        assert(test.was_run)

    def test_set_up(self):
        test = WasRun("test_method")
        test.run()
        assert(test.was_set_up)

TestCaseTest("test_running").run()
TestCaseTest("test_set_up").run()