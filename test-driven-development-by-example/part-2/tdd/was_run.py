class WasRun:
    def __init__(self, test_name):
        self.was_run = None
    
    def test_method(self):
        self.was_run = True

    def run(self):
        self.test_method()