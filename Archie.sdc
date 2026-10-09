derive_pll_clocks
derive_clock_uncertainty

# The reconfigurable video PLL has no defined phase relationship to the
# system, framework, or HDMI clocks. All crossings use explicit CDC logic.
set_clock_groups -asynchronous \
	-group [get_clocks {*|VIDEO_PLL|altera_pll_i|*[0].*|divclk}] \
	-group [get_clocks {*|pll|pll_inst|altera_pll_i|*[*].*|divclk}]
set_clock_groups -asynchronous \
	-group [get_clocks {*|VIDEO_PLL|altera_pll_i|*[0].*|divclk}] \
	-group [get_clocks {pll_hdmi|pll_hdmi_inst|altera_pll_i|*[0].*|divclk}]
set_clock_groups -asynchronous \
	-group [get_clocks {*|VIDEO_PLL|altera_pll_i|*[0].*|divclk}] \
	-group [get_clocks {*|h2f_user0_clk}]

set_multicycle_path -from [get_clocks {*|pll|pll_inst|altera_pll_i|*[1].*|divclk}] -to [get_clocks {*|pll|pll_inst|altera_pll_i|*[0].*|divclk}] -setup 2
set_multicycle_path -from [get_clocks {*|pll|pll_inst|altera_pll_i|*[1].*|divclk}] -to [get_clocks {*|pll|pll_inst|altera_pll_i|*[0].*|divclk}] -hold 1

set_multicycle_path -from {emu|SDRAM|sd_refresh*} -setup 2
set_multicycle_path -from {emu|SDRAM|sd_refresh*} -hold 1
set_multicycle_path -from {emu|SDRAM|reset*} -setup 2
set_multicycle_path -from {emu|SDRAM|reset*} -hold 1
