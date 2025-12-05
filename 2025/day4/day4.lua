
local input <close> = io.open("input.txt")
local lines = {}
local res1 = 0
local res2 = 0
for line in input:lines() do
    local split = {}
    for c in line:gmatch("%S") do
        table.insert(split, c)
    end
    table.insert(lines, split)
end

local function isAccessible(lines, i, j)
    local count = 0
    for shifti = -1, 1 do
        for shiftj = -1, 1 do
            if (lines[i + shifti] or {})[j + shiftj] == '@' and (shifti ~= 0 or shiftj ~= 0) then
                count = count + 1
            end
        end
    end
    return count < 4
end

for i = 1, #lines do
    for j = 1, #lines[1] do
        if lines[i][j] == '@' then
            if isAccessible(lines, i, j) then
                res1 = res1 + 1
            end
        end
    end
end

local flag = true
while flag do
    flag = false
    local newLines = {}
    for i = 1, #lines do
        local newLine = {}
        table.insert(newLines, newLine)
        for j = 1, #lines[1] do
            if lines[i][j] == '@' and isAccessible(lines, i, j) then
                res2 = res2 + 1
                table.insert(newLine, '.')
                flag = true
            else
                table.insert(newLine, lines[i][j])        
            end
        end
    end
    lines = newLines
end

print("Part 1:", res1)
print("Part 2:", res2)