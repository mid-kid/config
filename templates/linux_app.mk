name := name

dir_source := source
dir_build := build

OPTIM := -Os -g -fdata-sections -ffunction-sections -flto -fuse-linker-plugin -fgraphite-identity
CFLAGS := $(OPTIM) -Wall -Wextra -std=c11 -DPROGRAM_NAME="\"$(name)\""
LDFLAGS := $(OPTIM) -Wl,--gc-sections -Wl,--print-gc-sections

CFLAGS += #$(shell pkg-config ...)
LDLIBS := #$(shell pkg-config ...)

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))
objects := $(patsubst $(dir_source)/%.c, $(dir_build)/%.o, $(call rwildcard, $(dir_source)/, *.c))

.SECONDEXPANSION:

.PHONY: all
all: $(name)

.PHONY: clean
clean:
	rm -rf $(dir_build) $(name)

$(name): $(objects)
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(dir_build)/%.o: $(dir_source)/%.c | $$(dir $$@)
	$(COMPILE.c) -MM -MF $(@:.o=.d) $(OUTPUT_OPTION) $<

.PRECIOUS: %/
%/:
	mkdir -p $@

-include $(patsubst %.o, %.d, $(objects))
