{
  description = "dynamic-network-architectures";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  #inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  #inputs.connected-components-3d.url = "../connected-components-3d";

  outputs = { self, nixpkgs, flake-utils}:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "dynamic_network_architectures";
        version = "0.2";
        python = pkgs.python39;
      in
      {
        packages.dynamic-network-architectures  = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          src = python.pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-8YpxX2qZRVdBq4mBi4Fm/OME1iuVwWKWVvKTNI/+YT4=";
          };

          buildInputs = with pkgs; with python39Packages; [
            pytorch
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
