name := name

dir_source := source
dir_build := build

TARGET_ARCH := -mpic14 -p16f877a --use-non-free --no-extended-instructions
TARGET_GPASM := -p16f877a
TARGET_PK2CMD := -PPIC16f877a

CC := sdcc
AS := gpasm

CFLAGS := -Wp,-Wall --std-c11 -MMD --opt-code-size

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))
objects := $(patsubst $(dir_source)/%.c, $(dir_build)/%.o, $(call rwildcard, $(dir_source)/, *.c))
objects += $(patsubst $(dir_source)/%.asm, $(dir_build)/%.o, $(call rwildcard, $(dir_source)/, *.asm))

.SECONDEXPANSION:

.PHONY: all
all: $(name).hex

.PHONY: clean
clean:
	rm -rf $(dir_build) $(name).hex $(name).lst $(name).cod

.PHONY: upload
upload: $(name).hex
	pk2cmd -J -M $(TARGET_PK2CMD) -F$<

$(name).hex: $(objects)
	$(LINK.o) $(OUTPUT_OPTION) $^

$(dir_build)/%.o: $(dir_source)/%.c | $$(dir $$@)
	$(COMPILE.c) $(OUTPUT_OPTION) $<

$(dir_build)/%.o: $(dir_source)/%.asm | $$(dir $$@)
	$(AS) $(TARGET_GPASM) $(OUTPUT_OPTION) -c $<

.PRECIOUS: %/
%/:
	mkdir -p $@

-include $(patsubst %.o, %.d, $(objects))
