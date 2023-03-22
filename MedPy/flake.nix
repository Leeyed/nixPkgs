{
  description = "MedPy";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  # inputs.connected-components-3d.url = "../connected-components-3d";

  outputs = { self, nixpkgs, flake-utils , simpleitk }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "MedPy";
        version = "0.4.0";
        python = pkgs.python39;
      in
      {
        packages.MedPy = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          src = python.pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-+KlJN9u5R6sGnnZ4YtxrholrFTxBzo7ZNpx9ecADOog=";
          };

          buildInputs = with pkgs; with python39Packages; [
            numpy
            simpleitk.packages.${system}.SimpleITK
            scipy
          ];
          doCheck = false;
        };

        defaultPackage = self.packages.${system}.${pname};

        apps.${pname} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pname};
        };

        defaultApp = self.apps.${system}.${pname};
      }
    )
    );
}
