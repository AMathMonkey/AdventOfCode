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
        for _, g in ipairs(groups) do
            if g[distPair.n1] or g[distPair.n2] then
                return g
            end
        end
    end
    
    return function(distPair)
        local group = findExistingGroup(distPair)
        if group then
            if not group[distPair.n1] then
                group.n = group.n + 1
                group[distPair.n1] = true
            end
            if not group[distPair.n2] then
                group.n = group.n + 1
                group[distPair.n2] = true
            end
        else
            group = {n = 2, [distPair.n1] = true, [distPair.n2] = true}
            table.insert(groups, group)
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
        local newGroup = {n = 0}
        for k in pairs(groups[n1]) do
            if k ~= 'n' and not newGroup[k] then
                newGroup[k] = true
                newGroup.n = newGroup.n + 1
            end
        end
        for k in pairs(groups[n2]) do
            if k ~= 'n' and not newGroup[k] then
                newGroup[k] = true
                newGroup.n = newGroup.n + 1
            end
        end
        table.insert(newGroups, newGroup)
        return newGroups
    end

    return function(groups)
        for i = 1, #groups do
            local group1 = groups[i]
            for j = i + 1, #groups do
                local group2 = groups[j]
                for k in pairs(group1) do
                    if k ~= 'n' and group2[k] then
                        return mergeGroups(groups, i, j), true
                    end
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

table.sort(groups, function(g1, g2) return g1.n > g2.n end)

local res1 = 1
for i = 1, 3 do
    res1 = res1 * groups[i].n
end

print("Part 1:", res1)

local i = 1000
while groups[1].n ~= 1000 do
    i = i + 1
    addDistPair(dists[i])
    groups = tryMergeGroups(groups)
end

print("Part 2:", boxes[dists[i].n1][1] * boxes[dists[i].n2][1])
