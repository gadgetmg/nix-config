{ pkgs, lib, writeShellApplication }: writeShellApplication {
  name = "openweathermap-fullfeatured.sh";
  runtimeInputs = with pkgs; [ coreutils curl jq ];
  text = builtins.readFile ./openweathermap-fullfeatured.sh;
}
