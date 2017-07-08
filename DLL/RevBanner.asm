.model flat, stdcall
option casemap :none

include UHC.inc

extern pUHCInfo:UHCInfoPtr
extern hProcess:DWORD

.code

CheckRevBanner proto stdcall lpTechName:DWORD, lpThis:DWORD, lpPathObject:DWORD

code_cave_begin 0081A7CCh
	jnz rev_check
	push 00C0ECC8h
	lea ecx, [esp + 02Ch]
	mov eax, 00401A12h
	call eax
	lea eax, [esp + 028h]
	push eax
	mov ecx, ebp
	mov eax, 00638823h
	call eax
	lea ecx, [esp + 028h]
	jmp rev_check_end
rev_check:
	lea edi, [esp + 028h]
	push edi
	push ebp
	push eax
	call CheckRevBanner
	test eax, eax
	je_rel32 0081A7F1h
	lea ecx, [esp + 028h]
rev_check_end:
code_cave_end 0081A7ECh

public stdcall PatchRevBanner
PatchRevBanner proc
	patch_code_cave 0081A7CCh, 0081A7ECh
	invoke PatchAddress, hProcess, loc_0081A7F1h, 0081A7F1h, 1
	ret
PatchRevBanner endp

end