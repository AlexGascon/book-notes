class TestCase:
    def __init__(self, test_name):
        self.test_name = test_name

    def run(self):
        method = getattr(self, self.test_name)
        method()
