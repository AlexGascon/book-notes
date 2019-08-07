class TestCase:
    def __init__(self, test_name):
        self.test_name = test_name

    def test_set_up(self):
        pass

    def run(self):
        self.test_set_up()
        method = getattr(self, self.test_name)
        method()
