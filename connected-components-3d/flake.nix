{
  description = "connected-components-3d";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
 # inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "connected_components_3d";
        version = "3.10.5";
        format = "wheel";
        python = pkgs.python39;
      in
      {
        packages.connected-components-3d = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          format = format;
          src = python.pkgs.fetchPypi {
            inherit pname version format;
            sha256 = "sha256-uYpu97Hr7Ura5zBCv+zug3A7/y8YwNPc4p7E/RPicbE=";
            # sha256 = pkgs.lib.fakeSha256;
            dist = "cp39";
            abi = "cp39";
            python = "cp39";
            platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
          };

          buildInputs = with pkgs; with python39Packages; [
            numpy
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
