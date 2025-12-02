input = io.open('input.txt')

local res1 = 0
local dial = 50
for line in input:lines() do
    local sign = 1 
    if line:sub(1, 1) == 'L' then
        sign = -1
    end
    dial = dial + sign * line:sub(2)
    if dial % 100 == 0 then
        res1 = res1 + 1
    end 
end

print("Part 1:", res1)
