
local input <close> = io.open("input.txt")
local lines = {}
local res1 = 0
for line in input:lines() do
    local split = {}
    for c in line:gmatch("%S") do
        table.insert(split, c)
    end
    table.insert(lines, split)
end
for i = 1, #lines do
    for j = 1, #lines[1] do
        if lines[i][j] == '@' then
            local count = 0
            for shifti = -1, 1 do
                for shiftj = -1, 1 do
                    if (lines[i + shifti] or {})[j + shiftj] == '@' and (shifti ~= 0 or shiftj ~= 0) then
                        count = count + 1
                    end
                end
            end
            if count < 4 then
                res1 = res1 + 1
            end
        end
    end
end

print("Part 1:", res1)