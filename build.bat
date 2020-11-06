
nasm bootloader.asm -f bin -o bootloader.bin
nasm kernel.asm -f elf32 -o extended.o

wsl $WSLENV/x86_64-elf-gcc -ffreestanding -mno-red-zone -m16 -c "Kernel.cpp" -o "Kernel.o"

wsl $WSLENV/x86_64-elf-ld -melf_i386 -o kernel.tmp -Ttext 0x7e00 extended.o Kernel.o

wsl objcopy -O binary kernel.tmp kernel.bin

copy /b bootloader.bin+kernel.bin zakos.flp

pause