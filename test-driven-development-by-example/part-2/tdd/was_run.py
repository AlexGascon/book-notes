class WasRun:
    def __init__(self, test_name):
        self.was_run = None
        self.test_name = test_name

    def run(self):
       method = getattr(self, self.test_name)
       method()

    def test_method(self):
        self.was_run = True