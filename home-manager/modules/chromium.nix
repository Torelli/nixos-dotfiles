{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {
        id = "dcpihecpambacapedldabdbpakmachpb";
        updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      } # bypass-paywalls-chrome
      {id = "gebbhagfogifgggkldgodflihgfeippi";} # return youtube dislike
      {id = "jiaopdjbehhjgokpphdfgmapkobbnmjp";} # shorts block
      {id = "bfbnagnphiehemkdgmmficmjfddgfhpl";} # ultrawideo
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsorblock
    ];
  };
}
