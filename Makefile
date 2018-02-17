GIT_COMMIT := $(shell echo "`git rev-parse --short HEAD``git diff-index --quiet HEAD -- || echo '-dirty'`")

all: out/external_ui-$(GIT_COMMIT).hmod

out/external_ui-$(GIT_COMMIT).hmod:
	mkdir -p out/ temp/
	rsync -a mod/ temp/ --links --delete
	echo "---" > temp/readme.md
	echo "Name: `head -n 1 mod/readme.md | cut -c 3-`" >> temp/readme.md
	echo "Creator: DanTheMan827" >> temp/readme.md
	echo "Category: USB-Host" >> temp/readme.md
	echo "Packed on: `date`" >> temp/readme.md
	echo "Git commit: $(GIT_COMMIT)" >> temp/readme.md
	echo "---" >> temp/readme.md
	sed 1d mod/readme.md >> temp/readme.md
	cd temp/; tar -czvf "../$@" *
	rm -r temp/
	touch "$@"

clean:
	-rm -rf out/

.PHONY: clean
