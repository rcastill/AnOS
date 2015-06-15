SRC_DIR = src/
BUILD_DIR = build/

ifeq ($(shell uname), Linux)
	COMPILER = i686-elf

else
	COMPILER = osdev-res/bin/i686-pc-elf

endif

boot:
	$(COMPILER)-as $(SRC_DIR)boot.s -o $(BUILD_DIR)boot.o

