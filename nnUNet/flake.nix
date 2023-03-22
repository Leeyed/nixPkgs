{
  description = "test flake";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.simpleitk.url = "git+ssh://git@github.com/lizi002/nix-SimpleITK?ref=main";
  inputs.myPyPkgs.url = "git+ssh://git@github.com/Leeyed/nixPkgs?ref=main";

  outputs = { self, nixpkgs, flake-utils, myPyPkgs, simpleitk }:
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

          pname = "nnUNet";
          version = "2.0";
          python = pkgs.python39;
          pyPkgs = pkgs.python39Packages;

        in
        {
          packages.${pname} = python.pkgs.buildPythonPackage {
            pname = "${pname}";
            version = "${version}";

            propagatedBuildInputs = with pyPkgs; [
              pytorch
              tqdm
              dicom2nifti
              myPyPkgs.packages.${system}.acvl-utils
              myPyPkgs.packages.${system}.dynamic-network-architectures
              myPyPkgs.packages.${system}.MedPy
              scikitimage
              scipy
              batchgenerators
              numpy
              scikit-learn
              simpleitk.packages.${system}.SimpleITK
              pandas
              pyPkgs.graphviz
              tifffile
              requests
              nibabel
              matplotlib
              seaborn
              imagecodecs-lite
              yacs
            ];
            src = pkgs.fetchFromGitHub {
              owner = "MIC-DKFZ";
              repo = pname;
              rev = "93e1f4afddd22fada75123e64f186a61a0522fe8";
              sha256 = "1ibrwal80z27c2mh9hx85idmzilx6cpcmgc15z3lyz57bz0krigb";
            };
          };

          defaultPackage = self.packages.${system}.${pname};

          apps.${pname} = flake-utils.lib.mkApp {
            drv = self.packages.${system}.${pname};
          };

          defaultApp = self.apps.${system}.${pname};

          devShell = pkgs.mkShell {
            packages = [ self.packages.${system}.${pname} ];
          };
        }
      )
    );
}
