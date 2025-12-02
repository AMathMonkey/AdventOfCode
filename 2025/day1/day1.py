import math

with open('input.txt') as input:
    res1 = 0
    res2 = 0
    dial = 50
    for line in input:
        sign = 1 if line[0] == 'R' else -1
        diff = sign * int(line[1:])
        res2 += abs(diff) // 100
        if dial and not 0 < (dial + math.fmod(diff, 100)) < 100: res2 += 1
        dial = (dial + diff) % 100
        if not dial: res1 += 1

print("Part 1:", res1)
print("Part 2:", res2)
