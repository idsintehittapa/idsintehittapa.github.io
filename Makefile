ifeq ($(shell uname -s), Darwin)
HUGO_OS=macOS
else ifeq ($(shell uname -s), Linux)
HUGO_OS=Linux
else ifeq
HUGO_OS=notset
endif

HUGO_VERSION=0.60.1
HUGO=./_src/bin/hugo_$(HUGO_VERSION)_$(HUGO_OS)
HUGO_OPTS=--source _src --destination ../
HUGO_TEST_OPTS=-D -E -F

ifneq ($(BIND), )
HUGO_OPTS:=$(HUGO_OPTS) --bind $(BIND)
endif

.PHONY: serve
serve:
	$(HUGO) serve \
		$(HUGO_TEST_OPTS) \
		$(HUGO_OPTS)

.PHONY: gen
gen: clean
	$(HUGO) \
		$(HUGO_OPTS)

.PHONY: clean
clean:
	find -maxdepth 1 -not \(\
		-name '.*' -or \
		-name '_src' -or \
		-name 'Makefile' -or \
		-name 'LICENSE' \
		\) -print0 | xargs -0  -I {} rm -rf {}
