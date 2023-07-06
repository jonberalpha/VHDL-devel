-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         fpga_top_struc_cfg
-- FILENAME:       fpga_top_struc_cfg.vhd
-- ARCHITECTURE:   struc
-- ENGINEER:       Jonas Berger
-- DATE:           19.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the configuration for the entity fpga_top and the
--                 architecture struc
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       (none)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.09.2022
-------------------------------------------------------------------------------

configuration fpga_top_struc_cfg of fpga_top is
    for struc              -- architecture struc is used for entity fpga_top
    end for;
end fpga_top_struc_cfg;
