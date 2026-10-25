local Assembler={}
local op={NOP=0x00,LDAI=0x01,LDBI=0x02,LDCI=0x03,LDDI=0x04,LDA=0x05,STA=0x06,ADD=0x07,SUB=0x08,AND=0x09,OR=0x0A,XOR=0x0B,INC=0x0C,DEC=0x0D,JMP=0x0E,JZ=0x0F,JNZ=0x10,JC=0x11,JNC=0x12,CMP=0x13,OUT=0x14,IN=0x15,PUSH=0x16,POP=0x17,CALL=0x18,RET=0x19,SHL=0x1A,SHR=0x1B,ROL=0x1C,ROR=0x1D,HLT=0x1E}
local function num(s) if s:sub(1,2)=='0x' then return tonumber(s:sub(3),16) elseif s:sub(1,2)=='0b' then return tonumber(s:sub(3),2) else return tonumber(s) end end
local function words(line) local t={}; for x in line:gmatch('%S+') do t[#t+1]=x:gsub(',','') end; return t end
local function addr(v) return {v&0xFF,(v>>8)&0xFF} end
function Assembler.assemble(src)
 local out={}; local labels={}; local lines={}
 for line in src:gmatch('[^\n]+') do line=line:gsub(';.*',''):gsub('^%s+',''):gsub('%s+$',''); if line~='' then lines[#lines+1]=line end end
 local pc=0
 for _,line in ipairs(lines) do local label,rest=line:match('^([%w_]+):%s*(.*)$'); if label then labels[label]=pc; line=rest end; if line and line~='' then local t=words(line); local m=t[1]:upper(); pc=pc+(({LDAI=2,LDBI=2,LDCI=2,LDDI=2,LDA=3,STA=3,JMP=3,JZ=3,JNZ=3,JC=3,JNC=3,OUT=3,IN=3,CALL=3})[m] or 1) end end
 end
 for _,line in ipairs(lines) do local label,rest=line:match('^([%w_]+):%s*(.*)$'); if label then line=rest end; if line and line~='' then local t=words(line); local m=t[1]:upper(); local o=op[m]; assert(o,'unknown instruction '..m); out[#out+1]=o; if m=='LDAI' or m=='LDBI' or m=='LDCI' or m=='LDDI' then out[#out+1]=num(t[2])&0xFF elseif ({LDA=1,STA=1,JMP=1,JZ=1,JNZ=1,JC=1,JNC=1,OUT=1,IN=1,CALL=1})[m] then local a=labels[t[2]] or num(t[2]); assert(a,'unknown address '..t[2]); local b=addr(a); out[#out+1]=b[1]; out[#out+1]=b[2] end end end
 return out
end
return Assembler
