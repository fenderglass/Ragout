OVLP_DIR := ragout/overlap/cpp_impl/
SYNTENY_DIR := ragout/maf2synteny/cpp_impl/
PYTHON_INCLUDE := /usr/include/python2.7
PYTHON_LIB := python2.7


UNAME := $(shell uname -s)
ifneq ($(wildcard /usr/bin/clang),)
	CPP := clang++ -std=c++11

	ifeq ($(UNAME),Darwin) #for macos
		CPP += -stdlib=libc++
		LDFLAGS := -l${PYTHON_LIB}
	endif
else
	CPP := g++ -std=c++11
endif


.PHONY: all overlap dependencies clean maf2synteny

export PYTHON_INCLUDE
export CPP
export LDFLAGS

all: overlap maf2synteny

overlap:
	make -C ${OVLP_DIR} pylib

maf2synteny:
	make -C ${SYNTENY_DIR} pylib

dependencies:
	scripts/install-deps.py

clean:
	make -C ${OVLP_DIR} pyclean
	make -C ${SYNTENY_DIR} pyclean
