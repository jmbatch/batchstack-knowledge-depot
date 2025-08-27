import cProfile
import time

def slow_function():
    time.sleep(1)
    return sum(range(10000))

def medium_function():
    time.sleep(0.5)
    return sum(range(5000))

def fast_function():
    return sum(range(1000))

def main():
    slow_function()
    medium_function()
    fast_function()

if __name__ == "__main__":
    # Profile the main function
    cProfile.run("main()", sort="time")
