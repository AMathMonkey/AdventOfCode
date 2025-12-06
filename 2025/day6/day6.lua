local function ipairs_range(tbl, first, last)
    return function(tbl, index)
        index = index + 1
        if (last and index > last) or index > #tbl then
            return
        end
        return index, tbl[index]
    end, tbl, first - 1
end

local input <close> = io.open("input.txt")
local lines = {}
for line in input:lines() do
    table.insert(lines, line)
end

local rows = {}
local ops = {}
for _, line in ipairs(lines) do
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

local getOpfunc = (function()
    local function add(a, b)
        return a + b
    end

    local function mult(a, b)
        return a * b
    end

    return function(op)
        if op == "*" then
            return mult
        else
            return add
        end
    end
end)()

local res1 = 0
for colNum = 1, #rows[1] do
    local opfunc = getOpfunc(ops[colNum])
    local colRes = rows[1][colNum]
    for _, row in ipairs_range(rows, 2) do
        colRes = opfunc(colRes, row[colNum])
    end
    res1 = res1 + colRes
end

print("Part 1:", res1)

local res2 = 0
local nums = {}
for colNum = #lines[1], 1, -1 do
    local curNum = ""
    local function maybeAddCurNum()
        if #curNum > 0 then
            table.insert(nums, math.tointeger(curNum))
        end
        curNum = ""
    end
    for _, line in ipairs(lines) do
        local char = line:sub(colNum, colNum) 
        if char:match("%d") then
            curNum = curNum .. char
        elseif char:match("[*+]") then
            maybeAddCurNum()
            local thisRes = nums[1]
            local opfunc = getOpfunc(char)
            for _, num in ipairs_range(nums, 2) do
                thisRes = opfunc(thisRes, num)
            end
            res2 = res2 + thisRes
            nums = {}
        end
    end
    maybeAddCurNum()
end

print("Part 2:", res2)
