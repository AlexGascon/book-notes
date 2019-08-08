from tdd.test_result import TestResult


class TestCase:
    def __init__(self, test_name):
        self.test_name = test_name

    def set_up(self):
        pass

    def tear_down(self):
        pass

    def run(self):
        result = TestResult()
        result.test_started()

        self.set_up()

        try:
            method = getattr(self, self.test_name)
            method()
        except:
            result.test_failed()

        self.tear_down()
        
        return result
