from tdd.was_run import WasRun

def test_test_was_run():
    test = WasRun("test_method")
    test.run()
    print(test.was_run)

if __name__ == "__main__":
    test_test_was_run()