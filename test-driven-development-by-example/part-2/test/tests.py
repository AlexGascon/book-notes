from tdd.test_case import TestCase
from tdd.was_run import WasRun


class TestCaseTest(TestCase):
    def set_up(self):
        self.test = WasRun("test_method")

    def test_running(self):
        self.test.run()
        assert(self.test.was_run)

    def test_set_up(self):
        self.test.run()
        assert(self.test.was_set_up)

TestCaseTest("test_running").run()
TestCaseTest("test_set_up").run()