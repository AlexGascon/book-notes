from tdd.test_case import TestCase


class WasRun(TestCase):
    def test_set_up(self):
        self.was_run = False
        self.was_set_up = True

    def test_method(self):
        self.was_run = True