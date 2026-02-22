{ pkgs, ... }:

{
  home.username = "yilgo";
  home.homeDirectory = "/home/yilgo";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    htop
    bat
    fzf
    git
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      g = "git";
      k = "kubectl";
    };
  };

  programs.git = {
      enable = true;
      userName = "yilgo";
      userEmail = "yilgo@outlook.de";
      extraConfig = {
        init.defaultBranch = "main";
      };

};
}
