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
        local start, end_ = table.unpack(range)
        if line >= start and line <= end_ then
            res1 = res1 + 1
            break
        end
    end
end

print("Part 1:", res1)

local function mergeRange(ranges)
    local function replaceRanges(r1, r2, new)
        local newRanges = {}
        for i, range in ipairs(ranges) do
            if i ~= r1 and i ~= r2 then
                table.insert(newRanges, range)
            end
        end
        if new then
            table.insert(newRanges, new)
        end
        return newRanges
    end
    for i, range in ipairs(ranges) do
        local start, end_ = table.unpack(range)
        for j, range2 in ipairs(ranges) do
            if i ~= j then
                local start2, end2 = table.unpack(range2)
                local rangeStartsDuring = start >= start2 and start <= end2
                local rangeEndsDuring = end_ >= start2 and end_ <= end2
                if rangeStartsDuring and rangeEndsDuring then
                    return replaceRanges(i), true
                elseif rangeStartsDuring and not rangeEndsDuring then
                    return replaceRanges(i, j, {start2, end_}), true
                elseif rangeEndsDuring then
                    return replaceRanges(i, j, {start, end2}), true
                end
            end
        end
    end
    return ranges, false
end

local hadEffect = true
while hadEffect do
    ranges, hadEffect = mergeRange(ranges)
end

local res2 = 0
for _, range in ipairs(ranges) do
    local start, end_ = table.unpack(range)
    res2 = res2 + end_ - start + 1
end

print("Part 2:", res2)
