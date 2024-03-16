{ pkgs }:

pkgs.cinny.override {
  conf = {
    defaultHomeserver = 0;
    homeserverList = [ "cofob.dev" ];
    allowCustomHomeservers = false;
    hashRouter.enabled = false;
    hashRouter.basename = "/";
  };
}
