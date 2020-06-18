# Azure IoT Central
> see https://aka.ms/autorest
```yaml
version: latest
azure-validator: true
openapi-type: data-plane
```
```yaml $(package-global)
input-file: Microsoft.IoTCentral/preview/2019-10-28-preview/iotcentralapps.json
```
```yaml $(package-app)
input-file: Microsoft.IoTCentral/preview/2019-10-28-preview/iotcentral.json
```
```yaml
batch:
    - package-global: true
    - package-app: true
```
```yaml
azure-arm: false
add-credentials: true
generate-metadata: true
license-header: MICROSOFT_MIT_NO_VERSION
```
