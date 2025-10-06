{
stdenv,
fetchFromGitHub,
libsForQt5,
makeWrapper
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "vtm_diagram_wrapper";
  version = "v1";

  src = fetchFromGitHub {
    owner = "Blezz-tech";
    repo = "bin-files";
    rev = finalAttrs.version;
    sha256 = "sha256-+0nhsfqSm3ntbeAhaFeKolsocbOkV0E5ywcOMat2hR4=";
  };

  nativeBuildInputs = [
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtx11extras

    libsForQt5.qt5.wrapQtAppsHook
  ];

  buildPhase = ''
    echo "No build needed, using existing binary"
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/VTM_diagram $out/bin/
  '';

  qtWrapperArgs = [
    "--set LD_LIBRARY_PATH ${libsForQt5.qt5.qtbase.out}/lib:${libsForQt5.qt5.qtdeclarative.out}/lib:${libsForQt5.qt5.qtwayland.out}/lib:${libsForQt5.qt5.qtx11extras.out}/lib"
    "--set-default"
    "QT_QPA_PLATFORM"
    "xcb"
  ];

})
