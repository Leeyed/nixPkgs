{
  description = "torchio";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.SimpleITKPkgs.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";

  outputs = { self, nixpkgs, flake-utils, SimpleITKPkgs }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        pname = "torchio";
        version = "0.18.83";
        python = pkgs.python39;
        format = "wheel";
        SimpleITK = SimpleITKPkgs.packages.${system}.SimpleITK;
      in
      {
        packages.${pname} = python.pkgs.buildPythonPackage {
          pname = pname;
          version = version;
          format = format;

          src = python.pkgs.fetchPypi {
            inherit pname version format;
            sha256 = "sha256-dxmd6dnBTfsofYG4Ed4+ZCs16dJ+CG7qyjXoJZbeFcM=";
            # sha256 = pkgs.lib.fakeSha256;
            dist = "py2.py3";
            #abi = "";
            python = "py2.py3";
            # platform = "manylinux_2_12_x86_64.manylinux2010_x86_64";
          };

          buildInputs = with pkgs; with python39Packages; [
            click
            deprecated
            nibabel
            humanize
            pytorch
            tqdm
            SimpleITK
          ];
          doCheck = false;
        };

        defaultPackage = self.packages.${system}.${pname};

        apps.${pname} = flake-utils.lib.mkApp {
          drv = self.packages.${system}.${pname};
        };

        defaultApp = self.apps.${system}.${pname};
        
        
        # devShell = with pkgs; with python39Packages; mkShell {
        #     buildInputs = [
        #       click
        #       deprecated
        #       nibabel
        #       humanize
        #       pytorch
        #       tqdm
        #       SimpleITK
        #       self.packages.${system}.${pname}
        #     ];
        # };
      }
    )
    );
}
