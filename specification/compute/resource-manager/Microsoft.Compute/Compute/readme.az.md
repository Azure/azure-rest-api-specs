## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(cloudservice)
tag: package-2020-10-01-preview-only
az:
  extensions: cloud-service
  namespace: azure.mgmt.compute
  package-name: azure-mgmt-compute
az-output-folder: $(azure-cli-extension-folder)/src/cloudservice
python-sdk-output-folder: $(az-output-folder)/azext_cloudservice/vendored_sdks/cloudservice
cli:
    cli-directive:
        - where:
            group: "*"
            op: "*"
          hidden: true
        - where:
            group: "CloudServiceRoleInstances"
            op: "*"
          hidden: false
        - where:
            group: "CloudServiceRoles"
            op: "*"
          hidden: false
        - where:
            group: "CloudServices"
            op: "*"
          hidden: false
        - where:
            group: "CloudServicesUpdateDomain"
            op: "*"
          hidden: false
directive:
  - where:
      group: cloud-service cloud-service-role-instance
    set:
      group: cloud-service role-instance
  - where:
      group: cloud-service cloud-service-role
    set:
      group: cloud-service role
  - where:
      group: cloud-service cloud-service-update-domain
    set:
      group: cloud-service update-domain
```

``` yaml $(az) && $(target-mode) == "core"
tag: package-2020-12-01-only
az:
  extensions: vm
  namespace: azure.mgmt.compute
  package-name: azure-mgmt-compute
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/vm
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/vm"
extension-mode: stable
compatible-level: track2
cli:
    cli-directive:
        - where:
            group: "*"
            op: "*"
          hidden: true
        - where:
            group: "SshPublicKeys"
            op: "*"
          hidden: false
        - where:
            group: "SshPublicKeys"
            op: "GenerateKeyPair"
          hidden: true
        - where:
            group: "*"
            op: "*"
            param: vmName
          alias: name
directive: 
  - where: 
      group: vm ssh-public-key
    set:
      group: sshkey
```
