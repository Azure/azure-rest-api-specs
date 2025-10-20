## Java
These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: ueInfo.json
    where:
      - $.definitions.UeInfo.properties.properties
      - $.definitions.UeInfo5G.properties.info
      - $.definitions.UeInfo5GProperties.properties.fivegGuti
      - $.definitions.UeInfo5GProperties.properties.connectionInfo
      - $.definitions.Guti5G.properties.plmn
      - $.definitions.Guti5G.properties.amfId
      - $.definitions.UeConnectionInfo5G.properties.locationInfo
      - $.definitions.UeConnectionInfo5G.properties.globalRanNodeId
      - $.definitions.UeConnectionInfo5G.properties.allowedNssai.items
      - $.definitions.UeSessionInfo5G.properties.snssai
      - $.definitions.UeSessionInfo5G.properties.ueIpAddress
      - $.definitions.UeSessionInfo5G.properties.ambr
      - $.definitions.UeSessionInfo5G.properties.qosFlow.items
      - $.definitions.UeInfo4G.properties.info
      - $.definitions.UeInfo4GProperties.properties.guti
      - $.definitions.UeInfo4GProperties.properties.connectionInfo
      - $.definitions.Guti4G.properties.plmn
      - $.definitions.Guti4G.properties.mmeId
      - $.definitions.UeConnectionInfo4G.properties.locationInfo
      - $.definitions.UeConnectionInfo4G.properties.globalRanNodeId
      - $.definitions.UeSessionInfo4G.properties.ueIpAddress
      - $.definitions.UeLocationInfo.properties.plmn
      - $.definitions.UeQOSFlow.properties.qfi
      - $.definitions.UeQOSFlow.properties.fiveqi
      - $.definitions.UeQOSFlow.properties.mbr
      - $.definitions.UeQOSFlow.properties.gbr
      - $.definitions.DnnIpPair.properties.ueIpAddress
    transform: $['x-ms-client-flatten'] = false
    reason: these properties should not be flattened
  - from: ts29571.json
    where:
      - $.definitions.GlobalRanNodeId.properties.plmnId
      - $.definitions.GlobalRanNodeId.properties.gNbId
    transform: $['x-ms-client-flatten'] = false
    reason: these properties should not be flattened
```