local input <close> = io.open("input.txt")

local rows = {}
local ops = {}
for line in input:lines() do
    local nums = {}
    for num in line:gmatch("%d+") do
        table.insert(nums, math.tointeger(num))
    end
    if #nums == 0 then
        for op in line:gmatch("[*+]") do
            table.insert(ops, op)
        end
    else
        table.insert(rows, nums)
    end
end

local function add(a, b)
    return a + b
end

local function mult(a, b)
    return a * b
end

local res1 = 0
for col = 1, #rows[1] do
    local opfunc
    if ops[col] == "*" then
        opfunc = mult
    else
        opfunc = add
    end
    local colRes = rows[1][col]
    for row = 2, #rows do
        colRes = opfunc(colRes, rows[row][col])
    end
    res1 = res1 + colRes
end

print("Part 1:", res1)
