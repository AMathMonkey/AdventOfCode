local input <close> = io.open("input.txt")
local ranges = {}
while true do
    local line = input:read()
    local start, end_ = line:match("(%d+)-(%d+)")
    if not start then
        break
    end
    table.insert(ranges, {math.tointeger(start), math.tointeger(end_)})
end

local res1 = 0
while true do
    local line = math.tointeger(input:read())
    if not line then
        break
    end
    for _, range in ipairs(ranges) do
        if line >= range[1] and line <= range[2] then
            res1 = res1 + 1
            break
        end
    end
end

print("Part 1:", res1)
