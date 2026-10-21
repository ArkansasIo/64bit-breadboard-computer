local Class = require('lua.class')

local CPU = Class.define('CPU')

function CPU:init(memory, bus)
    self.memory = memory
    self.bus = bus
    self.reg = { RAX=0, RBX=0, RCX=0, RDX=0, RSI=0, RDI=0, RSP=0, RBP=0,
                 R8=0, R9=0, R10=0, R11=0, R12=0, R13=0, R14=0, R15=0,
                 RIP=0, RFLAGS=0 }
    self.halted = false
    self.cycles = 0
end

function CPU:reset(entry)
    self.halted = false
    self.cycles = 0
    self.reg.RIP = entry or 0
    self.reg.RFLAGS = 2
end

function CPU:fetch8()
    local value = self.memory:read8(self.reg.RIP)
    self.reg.RIP = self.reg.RIP + 1
    return value
end

function CPU:step()
    if self.halted then return false end
    local opcode = self:fetch8()
    -- This model intentionally implements only a tiny educational opcode subset.
    if opcode == 0xF4 then
        self.halted = true
    elseif opcode == 0x90 then
        -- NOP
    else
        error(string.format('unsupported educational opcode 0x%02X', opcode))
    end
    self.cycles = self.cycles + 1
    return not self.halted
end

return CPU
