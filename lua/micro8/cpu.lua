local Class = require('lua.class')
local CPU = Class.define('Micro8CPU')

local function u8(v) return v & 0xFF end
local function u16(v) return v & 0xFFFF end

function CPU:init(memory, bus)
    self.memory, self.bus = memory, bus
    self.reg = { A=0, B=0, C=0, D=0, PC=0, SP=0xFFFE, FLAGS=0 }
    self.halted, self.cycles = false, 0
end

function CPU:reset(entry) self.reg.PC=entry or 0; self.reg.SP=0xFFFE; self.reg.FLAGS=0; self.halted=false; self.cycles=0 end
function CPU:fetch8() local v=self.memory:read8(self.reg.PC); self.reg.PC=u16(self.reg.PC+1); return v end
function CPU:fetch16() local lo=self:fetch8(); local hi=self:fetch8(); return lo | (hi << 8) end
function CPU:set_flags(v, carry) self.reg.FLAGS=0; if u8(v)==0 then self.reg.FLAGS=self.reg.FLAGS|1 end; if (v&0x80)~=0 then self.reg.FLAGS=self.reg.FLAGS|2 end; if carry then self.reg.FLAGS=self.reg.FLAGS|4 end end
function CPU:z() return (self.reg.FLAGS & 1) ~= 0 end
function CPU:c() return (self.reg.FLAGS & 4) ~= 0 end
function CPU:step()
    if self.halted then return end
    local op=self:fetch8()
    if op==0x00 then
    elseif op==0x01 then self.reg.A=self:fetch8(); self:set_flags(self.reg.A,false)
    elseif op==0x02 then self.reg.B=self:fetch8(); self:set_flags(self.reg.B,false)
    elseif op==0x03 then self.reg.C=self:fetch8(); self:set_flags(self.reg.C,false)
    elseif op==0x04 then self.reg.D=self:fetch8(); self:set_flags(self.reg.D,false)
    elseif op==0x05 then self.reg.A=self.memory:read8(self:fetch16()); self:set_flags(self.reg.A,false)
    elseif op==0x06 then self.memory:write8(self:fetch16(),self.reg.A)
    elseif op==0x07 then local x=self.reg.A+self.reg.B; self.reg.A=u8(x); self:set_flags(x,x>255)
    elseif op==0x08 then local x=self.reg.A-self.reg.B; self.reg.A=u8(x); self:set_flags(x,x<0)
    elseif op==0x09 then self.reg.A=u8(self.reg.A & self.reg.B); self:set_flags(self.reg.A,false)
    elseif op==0x0A then self.reg.A=u8(self.reg.A | self.reg.B); self:set_flags(self.reg.A,false)
    elseif op==0x0B then self.reg.A=u8(self.reg.A ~ self.reg.B); self:set_flags(self.reg.A,false)
    elseif op==0x0C then local x=self.reg.A+1; self.reg.A=u8(x); self:set_flags(x,x>255)
    elseif op==0x0D then local x=self.reg.A-1; self.reg.A=u8(x); self:set_flags(x,x<0)
    elseif op==0x0E then self.reg.PC=self:fetch16()
    elseif op==0x0F then local a=self:fetch16(); if self:z() then self.reg.PC=a end
    elseif op==0x10 then local a=self:fetch16(); if not self:z() then self.reg.PC=a end
    elseif op==0x11 then local a=self:fetch16(); if self:c() then self.reg.PC=a end
    elseif op==0x12 then local a=self:fetch16(); if not self:c() then self.reg.PC=a end
    elseif op==0x13 then local x=self.reg.A-self.reg.B; self:set_flags(x,x<0)
    elseif op==0x14 then self.bus:write8(self:fetch16(),self.reg.A)
    elseif op==0x15 then self.reg.A=self.bus:read8(self:fetch16()); self:set_flags(self.reg.A,false)
    elseif op==0x16 then self.reg.SP=u16(self.reg.SP-1); self.memory:write8(self.reg.SP,self.reg.A)
    elseif op==0x17 then self.reg.A=self.memory:read8(self.reg.SP); self.reg.SP=u16(self.reg.SP+1)
    elseif op==0x18 then local a=self:fetch16(); self.reg.SP=u16(self.reg.SP-2); self.memory:write8(self.reg.SP,self.reg.PC&0xFF); self.memory:write8(self.reg.SP+1,(self.reg.PC>>8)&0xFF); self.reg.PC=a
    elseif op==0x19 then local lo=self.memory:read8(self.reg.SP); local hi=self.memory:read8(self.reg.SP+1); self.reg.SP=u16(self.reg.SP+2); self.reg.PC=lo|(hi<<8)
    elseif op==0x1A then local x=self.reg.A<<1; self.reg.A=u8(x); self:set_flags(self.reg.A,x>255)
    elseif op==0x1B then local carry=(self.reg.A&1)~=0; self.reg.A=self.reg.A>>1; self:set_flags(self.reg.A,carry)
    elseif op==0x1C then local x=((self.reg.A<<1)|(self.reg.A>>7)); self.reg.A=u8(x); self:set_flags(self.reg.A,false)
    elseif op==0x1D then local x=(self.reg.A>>1)|((self.reg.A&1)<<7); self.reg.A=u8(x); self:set_flags(self.reg.A,false)
    elseif op==0x1E then self.halted=true
    else error(string.format('unknown Micro8 opcode %02X',op)) end
    self.cycles=self.cycles+1
end
function CPU:run(limit) limit=limit or 100000; local n=0; while not self.halted and n<limit do self:step(); n=n+1 end; return n end
return CPU
