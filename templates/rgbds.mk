name := name

dir_build := build
dir_source := src
dir_assets := assets

RGBASM := rgbasm
RGBGFX := rgbgfx
RGBLINK := rgblink
RGBFIX := rgbfix

RGBASMFLAGS := -p 0xff -L
RGBLINKFLAGS := -p 0xff -d -t
RGBFIXFLAGS := -p 0xff -j -m 0 -n 0 -r 0 -k "  " -i "    " -t "               "

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))
objects := $(patsubst $(dir_source)/%.asm, $(dir_build)/%.o, $(call rwildcard, $(dir_source)/, *.asm))

.SECONDEXPANSION:

.PHONY: all
all: $(name).gbc

.PHONY: clean
clean:
	rm -rf $(name).gbc $(name).sym $(dir_build)

$(name).gbc: $(objects)

%.gbc: %.link
	$(RGBLINK) $(RGBLINKFLAGS) -l $< -n $(@:.gbc=.sym) -o $@ $(filter-out $<, $^)
	$(RGBFIX) $(RGBFIXFLAGS) $@

$(dir_build)/%.o: $(dir_source)/%.asm | $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i $(dir_source)/ -M $(@:.o=.d) -o $@ $<

$(dir_build)/%.pal: $(dir_assets)/%.png | $$(dir $$@)
	$(RGBGFX) -p $@ $<

$(dir_build)/%.tilemap: $(dir_assets)/%.png | $$(dir $$@)
	$(RGBGFX) -u -t $@ $<

$(dir_build)/%.2bpp: $(dir_assets)/%.png | $$(dir $$@)
	$(RGBGFX) -u -o $@ $<

$(dir_build)/%.1bpp: $(dir_assets)/%.png | $$(dir $$@)
	$(RGBGFX) -d 1 -u -o $@ $<

.PRECIOUS: %/
%/:
	mkdir -p $@

-include $(patsubst %.o, %.d, $(objects))
