all: os.iso

kernel.bin:
	gcc -m32 -ffreestanding -c kernel/kernel.c -o kernel.o
	ld -m elf_i386 -T linker.ld kernel.o -o kernel.bin

os.iso: kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/kernel.bin
	cp boot/grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o openmos.iso iso

run: os.iso
	qemu-system-i386 -cdrom openmos.iso

clean:
	rm -rf *.o *.bin *.iso iso