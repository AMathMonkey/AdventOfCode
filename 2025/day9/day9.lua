local input <close> = io.open("input.txt")
local pairList = {}
for line in input:lines() do
    local pair = {}
    for n in line:gmatch("%d+") do
        table.insert(pair, n)
    end
    table.insert(pairList, pair)
end

local res1 = 0

for i, pair1 in ipairs(pairList) do
    for j = i + 1, #pairList do
        local pair2 = pairList[j]
        res1 = math.max(res1, (math.abs(pair1[1] - pair2[1]) + 1) * (math.abs(pair1[2] - pair2[2]) + 1))
    end
end

print("Part 1:", res1)
