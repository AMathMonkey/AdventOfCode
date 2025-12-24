local input <close> = io.open("input.txt")
local pairList = {}
for line in input:lines() do
    local n1, n2 = line:match("(%d+),(%d+)")
    table.insert(pairList, {math.tointeger(n1), math.tointeger(n2)})
end

local res1 = 0

for i, pair1 in ipairs(pairList) do
    for j = i + 1, #pairList do
        local pair2 = pairList[j]
        res1 = math.max(res1, (math.abs(pair1[1] - pair2[1]) + 1) * (math.abs(pair1[2] - pair2[2]) + 1))
    end
end

print("Part 1:", res1)

table.insert(pairList, pairList[1])

local lines = {}

for i = 2, #pairList do
    local prevX, prevY = table.unpack(pairList[i - 1])
    local x, y = table.unpack(pairList[i])
    if prevX == x then
        if prevY > y then y, prevY = prevY, y end
    else
        if prevX > x then x, prevX = prevX, x end
    end
    table.insert(lines, {prevX, x, prevY, y})
end

local function lineIntersectsRectangle(xStart, xEnd, yStart, yEnd)
    for _, line in ipairs(lines) do
        local lineXStart, lineXEnd, lineYStart, lineYEnd = table.unpack(line)
        if lineXStart < xEnd and lineYStart < yEnd and lineXEnd > xStart and lineYEnd > yStart then
            return true
        end
    end
end

local res2 = 0

for i, pair1 in ipairs(pairList) do
    for j = i + 1, #pairList do
        local pair2 = pairList[j]
        local xStart = pair1[1]
        local xEnd = pair2[1]
        if xStart > xEnd then
            xStart, xEnd = xEnd, xStart
        end
        local yStart = pair1[2]
        local yEnd = pair2[2]
        if yStart > yEnd then
            yStart, yEnd = yEnd, yStart
        end
        local area = (xEnd - xStart + 1) * (yEnd - yStart + 1)
        if area > res2 and not lineIntersectsRectangle(xStart, xEnd, yStart, yEnd) then
            res2 = area
        end
    end
end

print("Part 2:", res2)
