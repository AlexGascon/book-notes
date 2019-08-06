from tdd.test_case import TestCase


class WasRun(TestCase):
    def __init__(self, test_name):
        self.was_run = None
        super().__init__(test_name)

    def test_method(self):
        self.was_run = True