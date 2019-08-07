from tdd.test_case import TestCase


class WasRun(TestCase):
    def set_up(self):
        self.was_run = False
        self.log = "set_up "

    def test_method(self):
        self.was_run = True
        self.log += "test_method "