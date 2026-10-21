local Class = require('lua.class')

local UART = Class.define('UART')

function UART:init()
    self.tx = {}
    self.rx = {}
    self.status = 1 -- illustrative TX-ready flag
end

function UART:read8(offset)
    if offset == 0 then
        local value = table.remove(self.rx, 1) or 0
        return value
    elseif offset == 4 then
        return self.status
    end
    return 0
end

function UART:write8(offset, value)
    if offset == 0 then
        table.insert(self.tx, value & 0xFF)
        io.write(string.char(value & 0xFF))
        io.flush()
    end
end

return UART
