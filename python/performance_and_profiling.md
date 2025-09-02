# Performance and Profiling

## timeit

- Benchmark small snippets

```bash
python -m timeit "sum(range(1000))"
```

### timeit example

```bash
jmbatch@jb-pc-01:~/dev/batchstack-knowledge-depot/python$ python3 -m timeit "sum(range(1000))"
50000 loops, best of 5: 6.02 usec per loop
jmbatch@jb-pc-01:~/dev/batchstack-knowledge-depot/python$
```

## cProfile

- Profile scripts

```bash
python -m cProfile script.py
```

### cProfile example

```bash
jmbatch@jb-pc-01:~/dev/batchstack-knowledge-depot/python$ python3 cprofile_demo.py 
         12 function calls in 1.501 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        2    1.500    0.750    1.500    0.750 {built-in method time.sleep}
        3    0.000    0.000    0.000    0.000 {built-in method builtins.sum}
        1    0.000    0.000    1.501    1.501 {built-in method builtins.exec}
        1    0.000    0.000    1.501    1.501 cprofile_demo.py:15(main)
        1    0.000    0.000    0.500    0.500 cprofile_demo.py:8(medium_function)
        1    0.000    0.000    1.000    1.000 cprofile_demo.py:4(slow_function)
        1    0.000    0.000    0.000    0.000 cprofile_demo.py:12(fast_function)
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
        1    0.000    0.000    1.501    1.501 <string>:1(<module>)


jmbatch@jb-pc-01:~/dev/batchstack-knowledge-depot/python$
```
