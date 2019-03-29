{ pkgs ? import <nixpkgs> {}}:
let
  inherit (pkgs) emacsWithPackages stdenvNoCC texinfo;
  emacs = emacsWithPackages (epkgs: with epkgs; [
    flycheck
    haskell-mode
    nix-mode
  ]);
in stdenvNoCC.mkDerivation {
  name = "nix-mode";
  src = ./.;
  nativeBuildInputs = [ emacs texinfo ];
  makeFlags = [ "PREFIX=$(out)" ];
}
