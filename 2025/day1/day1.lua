local input <close> = io.open('input.txt')

local res1 = 0
local res2 = 0
local dial = 50
for line in input:lines() do
    local sign = 1 
    if line:sub(1, 1) == 'L' then
        sign = -1
    end
    local diff = sign * line:sub(2)
    res2 = res2 + math.abs(diff) // 100
    if dial ~= 0 then 
        local tmp = dial + math.fmod(diff, 100)
        if tmp <= 0 or tmp >= 100 then
            res2 = res2 + 1
        end
    end
    dial = (dial + diff) % 100
    if dial == 0 then
        res1 = res1 + 1
    end
end

print("Part 1:", res1)
print("Part 2:", res2)
