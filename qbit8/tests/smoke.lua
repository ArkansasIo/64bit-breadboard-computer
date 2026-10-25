local Computer=require('lua.micro8.computer')
local Assembler=require('qbit8.assembler')
local source=[[LDAI 2
LDBI 3
ADD
STA 0x8000
HLT]]
local bytes=Assembler.assemble(source)
local c=Computer(); c:load(bytes,0); c:reset(0); c:run(20)
assert(c.cpu.halted)
assert(c.cpu.reg.A==5)
assert(c.memory:read8(0x8000)==5)
print('Micro8 smoke test: PASS')
