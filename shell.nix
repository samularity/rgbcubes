{ pkgs ? import <nixpkgs> {} }:
let
  # TODO: from <stockholm>
  nodemcu-uploader-next = pkgs.python2Packages.buildPythonPackage rec {
      name = "nodemcu-uploader-${version}";
      version = "0.3.next";
      propagatedBuildInputs = with pkgs;[
        python2Packages.pyserial
      ];
      src = pkgs.fetchFromGitHub {
        owner = "kmpm";
        repo = "nodemcu-uploader";
        rev = "next";
        sha256 = "17nx7l7kqw2dpp99p2nwxj1cgamv7xm1a8r6hlpgdins2hnggplv";
      };
      doCheck = false;
  };
  nodemcu-uploader = pkgs.python2Packages.buildPythonPackage rec {
      name = "nodemcu-uploader-${version}";
      version = "0.3.0";
      propagatedBuildInputs = with pkgs;[
        python2Packages.pyserial
      ];
      src = pkgs.fetchurl {
        url = "https://pypi.python.org/packages/source/n/nodemcu-uploader/nodemcu-uploader-${version}.tar.gz";
        sha256 = "1rjsfnj3gawvdjdj2nngizpxln5d71gbx1l141520569p077mm65";
      };
      doCheck = false;
  };

  esptool = pkgs.python2Packages.buildPythonPackage rec {
      name = "esptool-${version}";
      version = "0.1.0";
      propagatedBuildInputs = with pkgs;[
        python2Packages.pyserial
      ];
      src = pkgs.fetchFromGitHub {
        owner = "themadinventor";
        repo = "esptool";
        rev = "master";
        sha256 = "09gxrk3jky3lx4j4qfsimx8z4irw7ii54c5va2cvx8r5hcs4hav2";
      };
      doCheck = false;
  };

in pkgs.stdenv.mkDerivation rec {
  name = "minikrebs-env";
  version = "1.1";
  buildInputs = with pkgs; [
    wget
    git
    gawk
    bash
    # platformio
    nodemcu-uploader-next
    esptool
  ];
    shellHook =''
      HISTFILE="$PWD/.histfile"
    '' ;
}
