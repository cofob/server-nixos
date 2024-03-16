{ pkgs }:

pkgs.cinny.override {
  conf = {
    defaultHomeserver = 0;
    homeserverList = [ "cofob.dev" ];
    allowCustomHomeservers = false;
    hashRouter.enabled = true;
    hashRouter.basename = "/";
  };
}
