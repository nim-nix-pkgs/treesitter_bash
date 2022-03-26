{
  description = ''tree-sitter-bash wrapper for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-treesitter_bash-v0_1_1.flake = false;
  inputs.src-treesitter_bash-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-treesitter_bash-v0_1_1.owner = "genotrance";
  inputs.src-treesitter_bash-v0_1_1.repo  = "nimtreesitter";
  inputs.src-treesitter_bash-v0_1_1.dir   = "treesitter_bash";
  inputs.src-treesitter_bash-v0_1_1.type  = "github";
  
  inputs."nimgen".owner = "nim-nix-pkgs";
  inputs."nimgen".ref   = "master";
  inputs."nimgen".repo  = "nimgen";
  inputs."nimgen".dir   = "v0_5_1";
  inputs."nimgen".type  = "github";
  inputs."nimgen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimgen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."treesitter".owner = "nim-nix-pkgs";
  inputs."treesitter".ref   = "master";
  inputs."treesitter".repo  = "treesitter";
  inputs."treesitter".dir   = "v0_1_1";
  inputs."treesitter".type  = "github";
  inputs."treesitter".inputs.nixpkgs.follows = "nixpkgs";
  inputs."treesitter".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-treesitter_bash-v0_1_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-treesitter_bash-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}