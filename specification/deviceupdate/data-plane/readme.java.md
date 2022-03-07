## Java

``` yaml $(java)
packages:
- name: azure-iot-deviceupdate
  tag: package-2021-06-01-preview
  input-file:
  - Microsoft.DeviceUpdate/preview/2021-06-01-preview/deviceupdate.json
```

``` yaml $(java) && $(tag) == 'package-2021-06-01-preview'
namespace: com.azure.iot.deviceupdate
low-level-client: true
title: DeviceUpdateClient
artifact-id: azure-iot-deviceupdate
service-name: DeviceUpdate
generate-samples: true
service-versions:
  - '2021-06-01-preview'
polling: {}

generate-builder-per-client: false
```