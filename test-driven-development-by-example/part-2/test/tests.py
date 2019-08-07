from tdd.test_case import TestCase
from tdd.was_run import WasRun


class TestCaseTest(TestCase):
    def test_template_method(self):
        test = WasRun("test_method")
        test.run()
        assert("set_up test_method " == test.log)

TestCaseTest("test_template_method").run()