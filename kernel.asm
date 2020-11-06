
mov si, HELLO_STRING
call print

call _start

jmp $

print:
	pusha

	.Loop:
		cmp [si], byte 0
		je .End

		mov ah, 0x0E
		mov al, [si]
		int 0x10

		inc si

		jmp .Loop

	.End:
		popa
		ret

[extern _start]

HELLO_STRING:
	db 'Welcome to ZakOS16 version 0.0.1', 0x0a, 0x0d, 0
NEW_LINE:
	db 0x0a, 0x0d, 0

; times 2048-($-$$) db 0