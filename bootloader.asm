[org 0x7c00]

; Displaying message
mov si, BOOTLOADER_MSG
call print


; Loading kernel
call loadKernel

jmp $

loadKernel:
	pusha
	mov ah, 0x02
	mov dl, 0x00
	mov ch, 0
	mov dh, 0
	mov al, 4 ; Sectors to read
	mov cl, 2 ; Sector to start reading from

	push bx
	mov bx, 0
	mov es, bx
	pop bx
	mov bx, 0x7c00 + 512

	int 0x13

	jc readDiskError

	jmp 0x7e00


readDiskError:
	mov si, DISK_READ_ERROR
	call print

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


BOOTLOADER_MSG:
	db 'ZakOS16 Bootloader v 0.0.1.', 0x0a, 0x0d, 0x0a, 0x0d, 0

DISK_READ_ERROR:
	db 'Fatal error: failed to load a kernel from disk.', 0x0a, 0x0d, 0


times 510-($-$$) db 0
dw 0xaa55