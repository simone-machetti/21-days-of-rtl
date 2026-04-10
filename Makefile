# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

TOP_LEVEL ?= tmp
OUT_DIR   ?= tmp
PARAMS    ?= none

export SEL_TOP_LEVEL := $(TOP_LEVEL)
export SEL_OUT_DIR   := $(OUT_DIR)
export SEL_PARAMS    := $(PARAMS)

.PHONY: init

init:
	mkdir -p $(CODE_HOME)/rtl-lab/sim
	mkdir -p $(CODE_HOME)/rtl-lab/imp

sim: clean-sim
	cd $(CODE_HOME)/rtl-lab/scripts/sim && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/build && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/output && \
	./run.sh && \
	if [ -f $(CODE_HOME)/rtl-lab/scripts/sim/activity.vcd ]; then \
	mv $(CODE_HOME)/rtl-lab/scripts/sim/activity.vcd $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/output; \
	fi

syn: clean-imp
	cd $(CODE_HOME)/rtl-lab/scripts/syn && \
	mkdir -p $(CODE_HOME)/rtl-lab/imp/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/rtl-lab/imp/$(OUT_DIR)/output && \
	mkdir -p $(CODE_HOME)/rtl-lab/imp/$(OUT_DIR)/report && \
	yosys -l $(CODE_HOME)/rtl-lab/imp/$(OUT_DIR)/output/yosys.log -c $(CODE_HOME)/rtl-lab/scripts/syn/run.tcl

clean-all:
	rm -rf $(CODE_HOME)/rtl-lab/sim
	rm -rf $(CODE_HOME)/rtl-lab/imp

clean-sim:
	rm -rf $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)

clean-imp:
	rm -rf $(CODE_HOME)/rtl-lab/imp/$(OUT_DIR)
