{
  programs.git = {
    enable = true;
    signing.format = "ssh";
    userName = "Giovanni Torelli";
    userEmail = "giovanni.walter@outlook.com";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
