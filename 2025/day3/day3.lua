local input = io.open("input.txt")
local res1 = 0
for line in input:lines() do
    local counts = {}
    local max = 0
    for c in line:gmatch("%d") do
        local ci = math.tointeger(c)
        counts[ci] = (counts[ci] or 0) + 1
    end
    for c in line:gmatch("%d") do
        local ci = math.tointeger(c)
        counts[ci] = counts[ci] - 1
        if c > string.sub(max, 1, 1) then
            for i = 9, 0, -1 do
                if (counts[i] or 0) > 0 then
                    max = c .. i
                    break
                end
            end
        end
    end
    res1 = res1 + max
end
print("Part 1:", res1)