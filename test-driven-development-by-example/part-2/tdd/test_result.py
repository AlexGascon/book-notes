class TestResult:
    def __init__(self):
        self.run_count = 0

    def test_started(self):
        self.run_count += 1

    def summary(self):
        return f"{self.run_count} run, 0 failed"