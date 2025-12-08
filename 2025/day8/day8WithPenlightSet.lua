-- Alternative solution which is slightly more concise but almost twice as slow (3 seconds vs 1.75 seconds)
-- and it requires penlight to be installed via luarocks before you can run it

local Set = require 'pl.Set'

local input <close> = io.open("input.txt")
local boxes = {}
for line in input:lines() do
    local box = {}
    table.insert(boxes, box)
    for n in line:gmatch("%d+") do
        table.insert(box, math.tointeger(n))
    end
end

local dists = {}

for i, box1 in ipairs(boxes) do
    for j = i + 1, #boxes do
        local box2 = boxes[j]
        local dist = math.sqrt(math.pow(box1[1] - box2[1], 2) + math.pow(box1[2] - box2[2], 2) + math.pow(box1[3] - box2[3], 2))
        table.insert(dists, {n1 = i, n2 = j, dist = dist})
    end
end

table.sort(dists, function (d1, d2) return d1.dist < d2.dist end)

local groups = {}

local addDistPair = (function()
    local function findExistingGroup(distPair)
        for i, g in ipairs(groups) do
            if g[distPair.n1] or g[distPair.n2] then
                return i, g
            end
        end
    end
    
    return function(distPair)
        local newSet = Set{distPair.n1, distPair.n2}
        local i, group = findExistingGroup(distPair)
        if group then
            groups[i] = group + newSet
        else
            table.insert(groups, newSet)
        end
    end
end)()

for i = 1, 1000 do
    addDistPair(dists[i])
end

local tryMergeGroups = (function()
    local function mergeGroups(groups, n1, n2)
        local newGroups = {}
        for n, g in ipairs(groups) do
            if not (n == n1 or n == n2) then
                table.insert(newGroups, g)
            end
        end
        table.insert(newGroups, groups[n1] + groups[n2])
        return newGroups
    end

    return function(groups)
        for i = 1, #groups do
            local group1 = groups[i]
            for j = i + 1, #groups do
                local group2 = groups[j]
                if not Set.isdisjoint(group1, group2) then
                    return mergeGroups(groups, i, j), true
                end
            end
        end
        return groups, false
    end
end)()

local hadEffect = true
while hadEffect do
    groups, hadEffect = tryMergeGroups(groups)
end

table.sort(groups, function(g1, g2) return #g1 > #g2 end)

local res1 = 1
for i = 1, 3 do
    res1 = res1 * #groups[i]
end

print("Part 1:", res1)

local i = 1000
while #groups[1] ~= 1000 do
    i = i + 1
    addDistPair(dists[i])
    groups = tryMergeGroups(groups)
end

print("Part 2:", boxes[dists[i].n1][1] * boxes[dists[i].n2][1])
