{ pkgs }:

pkgs.mkShell {
  name = "my-dev-env";

  packages = [
    pkgs.python312
  ];

  shellHook = ''
    echo "Environment loaded from shell.nix!"
  '';
}
