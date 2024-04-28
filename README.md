# IceStick
Lattice IceStick FPGA project development

This repository will go over FPGA communication protocols that may require a higher clock speed than the IceSugar Nano's default.

1) IceSugar PMOD Audio related projects - Based on my experience testing with the Nano the MCO is not fast enough to produce music
 - This project uses the PMOD Audio v1.2 speaker from MuseLab.  
2) SDIO MicoSD card related projects - SDIO is supposed to be able to handle faster clock speeds than the default MCO of IceSugar Nano
 - This project will use the MicroSD card expansion board from MuseLab. (Has shipped but not yet arrived)
