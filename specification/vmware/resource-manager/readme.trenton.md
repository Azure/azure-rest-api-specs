
## trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
    cli-name: avs
    package-name: avs
clear-output-folder: true
output-folder: $(trenton-output-folder)/avs
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
