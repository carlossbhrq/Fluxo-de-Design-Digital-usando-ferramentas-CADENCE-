set_db init_lib_search_path ../lib/
set_db init_hdl_search_path ../rtl/
read_libs slow_vdd1v0_basicCells.lib

read_hdl multiplexor.v
elaborate
read_sdc ../constraints/constraints_multiplexor.sdc

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt

#reports
report_timing > reports/report_timing_MUX.rpt
report_power  > reports/report_power_MUX.rpt
report_area   > reports/report_area_MUX.rpt
report_qor    > reports/report_qor_MUX.rpt



#Outputs
write_hdl > outputs/multiplexor_netlist.v
write_sdc > outputs/multiplexor_sdc.sdc
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge  -setuphold split > outputs/delays_multiplexor.sdf
