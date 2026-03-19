# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

TOP_LEVEL ?= tmp
OUT_DIR   ?= tmp

export SEL_TOP_LEVEL := $(TOP_LEVEL)
export SEL_OUT_DIR   := $(OUT_DIR)

.PHONY: init

init:
	mkdir -p $(CODE_HOME)/21-days-of-rtl/sim

sim: clean-sim
	cd $(CODE_HOME)/21-days-of-rtl/scripts/sim && \
	mkdir -p $(CODE_HOME)/21-days-of-rtl/sim/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/21-days-of-rtl/sim/$(OUT_DIR)/build && \
	mkdir -p $(CODE_HOME)/21-days-of-rtl/sim/$(OUT_DIR)/output && \
	./run.sh && \
	if [ -f $(CODE_HOME)/21-days-of-rtl/scripts/sim/activity.vcd ]; then \
	mv $(CODE_HOME)/21-days-of-rtl/scripts/sim/activity.vcd $(CODE_HOME)/21-days-of-rtl/sim/$(OUT_DIR)/output; \
	fi

clean-all:
	rm -rf $(CODE_HOME)/21-days-of-rtl/sim

clean-sim:
	rm -rf $(CODE_HOME)/21-days-of-rtl/sim/$(OUT_DIR)
