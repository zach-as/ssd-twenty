{ pkgs, outputs }:
let
  ENV = outputs.envModule;
in
{
  init_default = pkgs.writeScriptBin "init_default" ''
    if ! [ psql -lqt | cut -d \| -f 1 | grep -qw default ]; then psql postgres -c "CREATE DATABASE \"default\";"" fi
  '';
}
