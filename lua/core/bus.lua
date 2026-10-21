local Class = require('lua.class')

local Bus = Class.define('Bus')

function Bus:init()
    self.devices = {}
    self.last_transaction = nil
end

function Bus:map(name, base, size, device)
    assert(not self.devices[name], 'device already mapped: ' .. name)
    self.devices[name] = { base = base, size = size, device = device }
end

function Bus:find(addr)
    for name, entry in pairs(self.devices) do
        if addr >= entry.base and addr < entry.base + entry.size then
            return name, entry, addr - entry.base
        end
    end
    return nil
end

function Bus:read8(addr)
    local name, entry, offset = self:find(addr)
    assert(entry, string.format('unmapped read at 0x%X', addr))
    local value = entry.device:read8(offset)
    self.last_transaction = { op='read8', address=addr, device=name, value=value }
    return value
end

function Bus:write8(addr, value)
    local name, entry, offset = self:find(addr)
    assert(entry, string.format('unmapped write at 0x%X', addr))
    entry.device:write8(offset, value)
    self.last_transaction = { op='write8', address=addr, device=name, value=value & 0xFF }
end

return Bus
