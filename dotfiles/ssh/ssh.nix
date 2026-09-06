{
  enable = true;
  enableDefaultConfig = false;

  settings = {
    "github.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/github";
    };
  };
}
