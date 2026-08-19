{ lib, stdenv, fetchFromGitHub, pkg-config, ncurses }:

stdenv.mkDerivation (finalAttrs: {
  pname = "csakura";
  version = "2.0.0-unstable-2026-08-08";

  src = fetchFromGitHub {
    owner = "realstrawhat";
    repo = "csakura";
    rev = "0001eb0c9d22bdb2c1ac09096cc18abc3f95ea9e";
    hash = "sha256-sLM02iA4NOq4hqEzUMl0vje0M/pSvzfo2e4u82hIsyw=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ ncurses ];

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "A sakura tree with falling petals for your terminal";
    longDescription = ''
      Procedurally grown cherry-blossom tree with drifting petals, in the
      spirit of cmatrix and cava but prettier. Written in C99 + ncurses.
    '';
    homepage = "https://github.com/realstrawhat/csakura";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
    mainProgram = "csakura";
  };
})
