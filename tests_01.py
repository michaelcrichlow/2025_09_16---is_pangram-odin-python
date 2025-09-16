import time

def isPangram(s):
    letters = list("abcdefghijklmnopqrstuvwxyz")
    s = list(s.lower())
    for i in letters:
        if i.lower() not in s:
            return False 
    return True

def isPangramFast(s):
    return set("abcdefghijklmnopqrstuvwxyz").issubset(set(s.lower()))


# Benchmark setup
iterations = 1000
total_time_ns = 0

for _ in range(iterations):
    start = time.perf_counter_ns()
    
    # Code to test
    isPangramFast("The quick brown fox jumps over the lazy dog")
    
    end = time.perf_counter_ns()
    total_time_ns += (end - start)

average_time_ns = total_time_ns // iterations
print("Average time:", average_time_ns, "ns")
