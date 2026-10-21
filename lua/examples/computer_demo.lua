local Computer = require('lua.core.computer')
local Monitor = require('lua.monitor')

local computer = Computer(64 * 1024)
computer.memory:write8(0, 0x90) -- NOP
computer.memory:write8(1, 0x90) -- NOP
computer.memory:write8(2, 0xF4) -- HLT
computer:reset(0)

local monitor = Monitor(computer)
monitor:run(10)
monitor:info()
print('CPU halted:', computer.cpu.halted)
