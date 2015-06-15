SRC_DIR = src/
KERNEL_DIR = $(SRC_DIR)kernel/
BUILD_DIR = build/

OSNAME = AnOS

ifeq ($(shell uname), Linux)
	COMPILER = i686-elf

else
	COMPILER = osdev-res/bin/i686-pc-elf

endif

all: mktree linker

mktree:
	mkdir -p $(BUILD_DIR)

boot:
	$(COMPILER)-as $(SRC_DIR)boot.s -o $(BUILD_DIR)boot.o

kernel:
	$(COMPILER)-gcc -c $(KERNEL_DIR)kernel.c -o $(BUILD_DIR)kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

linker: boot kernel
	i686-elf-gcc -T $(SRC_DIR)linker.ld -o $(BUILD_DIR)$(OSNAME).bin -ffreestanding -O2 -nostdlib \
	$(BUILD_DIR)boot.o $(BUILD_DIR)kernel.o -lgcc

run:
	qemu-system-i386 -kernel $(BUILD_DIR)$(OSNAME).bin

purge:
	rm -rf $(BUILD_DIR)