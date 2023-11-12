{ pkgs }: 

{
  enable = true;
  extraConfig = pkgs.lib.fileContents ./config.lua;
}
