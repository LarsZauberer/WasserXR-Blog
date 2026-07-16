{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  clusterLib = inputs.clusterLib.lib;
in
(inputs.kubenix.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
  specialArgs = { inherit inputs; };
  module =
    {
      kubenix,
      config,
      ...
    }:
    {
      imports = [
        kubenix.modules.k8s
        kubenix.modules.helm
        kubenix.modules.docker
      ];

      config = {
        docker.images.wasserxr-blog.image = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.docker;
        docker.registry.host = "registry.larszauberer.com";
        kubernetes.resources = lib.mkMerge [
          (clusterLib.createNamespace "wasserxr-blog")
          (clusterLib.createDeployment {
            name = "wasserxr-blog";
            namespace = "wasserxr-blog";
            image = config.docker.images.wasserxr-blog.path;
            ports = [ { port = 80; } ];
            replicas = 3;
            startupProbe = {
              path = "/";
              port = 80;
            };
            livenessProbe = {
              path = "/";
              port = 80;
            };
          })
          (clusterLib.createService {
            name = "wasserxr-blog";
            namespace = "wasserxr-blog";
            innerPort = 80;
          })
          (clusterLib.createIngress {
            name = "wasserxr-blog";
            namespace = "wasserxr-blog";
            domains = [
              "blog.wasserxr.com"
              "blog.wasserxr.ch"
              "blog.wasserxr.org"
              "blog.wasserxr.dev"
            ];
          })
        ];
      };
    };
})
