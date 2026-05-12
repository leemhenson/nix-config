{
  enable = true;
  enableDefaultConfig = false;

  matchBlocks = {
    "github.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/github";
    };
  };
}
