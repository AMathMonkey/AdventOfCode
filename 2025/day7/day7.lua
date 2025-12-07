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
