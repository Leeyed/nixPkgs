{
  description = "monai";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "monai";
        version = "0.9.0-202206131636";
        python = pkgs.python39;
        format = "wheel";
      in
      {
        packages.${pname} = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          format = format;

          src = python.pkgs.fetchPypi {
            inherit pname version format;
            sha256 = "sha256-jHccdnakpw4yR6htkAn0cR4sDX9VvNZKow6DgQZdvtE=";
            dist = "py3";
            #abi = "";
            python = "py3";
            # platform = "manylinux_2_12_x86_64.manylinux2010_x86_64";
          };

          buildInputs = with pkgs; with python39Packages; [
            numpy
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
