local function isInvalid1(n)
    local len = #tostring(n)
    if len % 2 ~= 0 then
        return false
    end
    return string.sub(n, 1, len//2) == string.sub(n, len//2 + 1)
end

local function isInvalid2(n)
    local len = #tostring(n)
    for i = 1, len - 1, 1 do
        if len % i == 0 then
            local ref = string.sub(n, 1, i)
            local satisfies = true
            for j = i + 1, len, i do
                if string.sub(n, j, j + i - 1) ~= ref then
                    satisfies = false
                    break
                end
            end
            if satisfies then
                return true
            end
        end
    end
    return false
end

local input = io.open('input.txt'):read()
local res1 = 0
local res2 = 0

for start, end_ in input:gmatch("(%d+)-(%d+)") do
    for i = math.tointeger(start), math.tointeger(end_) do
        if isInvalid1(i) then
            res1 = res1 + i
        end
        if isInvalid2(i) then
            res2 = res2 + i
        end
    end
end

print("Part 1:", res1)
print("Part 2:", res2)
