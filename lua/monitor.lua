local Class = require('lua.class')

local Monitor = Class.define('Monitor')

function Monitor:init(computer)
    self.computer = computer
end

function Monitor:info()
    local r = self.computer.cpu.reg
    print(string.format('RIP=%016X RAX=%016X RBX=%016X RCX=%016X RDX=%016X',
        r.RIP, r.RAX, r.RBX, r.RCX, r.RDX))
end

function Monitor:peek(addr)
    print(string.format('MEM[0x%X] = 0x%02X', addr, self.computer.memory:read8(addr)))
end

function Monitor:run(steps)
    for _ = 1, (steps or 1) do
        if not self.computer.cpu:step() then break end
    end
end

return Monitor
