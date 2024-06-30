{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable 32-bit support for Direct Rendering Infrastructure (DRI)
  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
}
