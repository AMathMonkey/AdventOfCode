local input = io.open("input.txt")
local res1 = 0
local res2 = 0

local function part1(line)
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
    return max
end

local function part2(line)
    line = line:match("(%d+)")
    local max = line:sub(1, 12)
    local function recur(acc, i)
        if #acc == 12 then
            if acc > max then
                max = acc 
            end
            return
        end
        if max:sub(1, #acc) > acc then
            return
        end
        if i > #line then
            return
        end
        recur(acc .. line:sub(i, i, 1), i + 1)
        recur(acc, i + 1)
    end
    recur("", 1)
    return math.tointeger(max)
end

for line in input:lines() do
    res1 = res1 + part1(line)
    res2 = res2 + part2(line)
end

print("Part 1:", res1)
print("Part 2:", res2)