{ lib, writeShellApplication }: writeShellApplication {
  name = "openweathermap-fullfeatured.sh";
  text = builtins.readFile ./openweathermap-fullfeatured.sh;
}
