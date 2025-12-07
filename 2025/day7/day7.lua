local input <close> = io.open("input.txt")
local grid = {}
for line in input:lines() do
    local row = {}
    for c in line:gmatch("%S") do
        if c == "S" then
            c = "|"
        end
        table.insert(row, c)
    end
    table.insert(grid, row)
end

local res1 = 0

for i = 1, #grid - 1 do
    local row = grid[i]
    for j, c in ipairs(row) do
        if c == "|" then
            if grid[i + 1][j] == "^" then
                res1 = res1 + 1
                if j > 1 then
                    grid[i + 1][j - 1] = "|"
                end
                if j < #row then
                    grid[i + 1][j + 1] = "|"
                end
            else
                grid[i + 1][j] = "|"
            end
        end
    end
end

print("Part 1:", res1)

for i = 1, #grid - 1 do
    local row = grid[i]
end

local recur = (function()
    local cache = {}
    local function recur(i, j)
        local key = i .. " " .. j
        local cached = cache[key]
        if cached then
            return cached
        end
        while true do
            if i >= #grid or j < 1 or j > #grid[1] then
                cache[key] = 0
                return 0
            end
            i = i + 1
            if grid[i][j] == "^" then
                local res = 1 + recur(i, j - 1) + recur(i, j + 1)
                cache[key] = res
                return res
            end
        end
    end
    return recur
end)()

local res2 = (function()
    for j, c in ipairs(grid[1]) do
        if c == "|" then
            return 1 + recur(1, j)
        end 
    end
end)()

print("Part 2:", res2)
