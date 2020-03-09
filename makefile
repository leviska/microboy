####################################################
# General makefile
# Calls makefiles/target.make file

MAKEFILES:=makefiles

all:
	@echo "Select target to build: linux, stm32"

linux: build

stm32: build

ifeq ($(MAKECMDGOALS), linux)
include linux.make
endif

ifeq ($(MAKECMDGOALS), stm32)
include stm32.make
endif

clean:
	rm -rf build/* bin/*