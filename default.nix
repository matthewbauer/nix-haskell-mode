{ pkgs ? import <nixpkgs> {}}:
let
  inherit (pkgs) emacsWithPackages stdenvNoCC texinfo;
  emacs = emacsWithPackages (epkgs: with epkgs; [
    flycheck
    haskell-mode
    nix-mode
  ]);
in stdenvNoCC.mkDerivation {
  name = "nix-haskell-mode-0.0.3";
  src = ./.;
  nativeBuildInputs = [ emacs ];
  makeFlags = [ "PREFIX=$(out)" ];
}
