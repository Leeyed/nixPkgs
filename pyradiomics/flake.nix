{
  description = "pyradiomics";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";

  outputs = { self, nixpkgs, flake-utils, simpleitk }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "pyradiomics";
        version = "3.0.1";
        pyversion = "python39";
        python = pkgs.${pyversion};
        pypkgs = pkgs.${"${pyversion}Packages"};

        #format = "wheel";
      in
      {
        packages.${pname} = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          # format = format;

          src = python.pkgs.fetchPypi {
            inherit 
              pname 
              version 
              # format
            ;
            sha256 = "R8V/RB1st5c/o7LqSNOUjfeOM0jhxp4eL/GQAWAfwvU=";
            # dist = "cp37";
            # abi = "cp37m";
            # python = "cp37";
            # platform = "manylinux1_x86_64";
          };
          buildInputs = with pypkgs; [
            numpy
            pykwalify
            pywavelets
            simpleitk.packages.${system}.SimpleITK
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