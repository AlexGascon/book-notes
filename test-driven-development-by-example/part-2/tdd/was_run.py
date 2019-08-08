from tdd.test_case import TestCase


class WasRun(TestCase):
    def set_up(self):
        self.log = "set_up "

    def tear_down(self):
        self.log += "tear_down "

    def test_method(self):
        self.log += "test_method "

    def test_broken_method(self):
        raise Exception