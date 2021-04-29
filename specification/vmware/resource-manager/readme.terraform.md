
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: avs
    package-name: avs
clear-output-folder: true
output-folder: $(terraform-output-folder)/avs
overrides:
    - where:
        property: baseGroupDn
      set:
        - GoFieldName: BaseGroupDN
    - where:
        property: baseUserDn
      set:
        - GoFieldName: BaseUserDN
    - where:
        property: managementCluster
      set:
        - Required: true
    - where:
        property: clusterSize
      set:
        - Required: true
    - where:
        property: /privateCloud/properties/identitySources/SSL
      set:
        - EnumValues/0/GoEnumMemberName: "SslEnumEnabled"
        - EnumValues/1/GoEnumMemberName: "SslEnumDisabled"
        - GoFieldName: "Ssl"
    - where:
        property: //properties/identitySources/SSL
      set:
        - GoFieldName: "Ssl"
```


``` yaml $(tag) == 'package-2021-01-01-preview' && $(terraform)
gosdk-folder: services/preview/avs/mgmt/2021-01-01-preview/avs
```

``` yaml $(tag) == 'package-2020-07-17-preview' && $(terraform)
gosdk-folder: services/preview/avs/mgmt/2020-07-17-preview/avs
```

``` yaml $(tag) == 'package-2020-03-20' && $(terraform)
gosdk-folder: services/avs/mgmt/2020-03-20/avs
```
