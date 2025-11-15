## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: iothubprovisioningservices
  package-name: azure-mgmt-iothubprovisioningservices
  namespace: azure.mgmt.iothubprovisioningservices
  test-scenario:
    - name: /IotDpsResource/put/DPSCreate
    - name: /DpsCertificate/put/DPSCreateOrUpdateCertificate
      disabled: true
      comment: Certificates not tested yet
    - name: /DpsCertificate/get/DPSGetCertificate
      disabled: true
      comment: Certificates not tested yet
    - name: /IotDpsResource/get/DPSGetOperationResult
      disabled: true
      comment: Certificates not tested yet
    - name: /DpsCertificate/get/DPSGetCertificates
    - name: /IotDpsResource/get/DPSGetValidSku
    - name: /IotDpsResource/get/DPSGet
    - name: /IotDpsResource/get/DPSListByResourceGroup
    - name: /IotDpsResource/get/DPSListBySubscription
    - name: /Operations/get/DPSOperations
    - name: /DpsCertificate/post/DPSGenerateVerificationCode
      disabled: true
      comment: Certificates not tested yet
    - name: /DpsCertificate/post/DPSVerifyCertificate
      disabled: true
      comment: Certificates not tested yet
    - name: /IotDpsResource/post/DPSGetKey
      disabled: true
      comment: Certificates not tested yet
    - name: /IotDpsResource/post/DPSListKeys
    - name: /IotDpsResource/patch/DPSPatch
    - name: /IotDpsResource/post/DPSCheckName
    - name: /DpsCertificate/delete/DPSDeleteCertificate
      disabled: true
      comment: Certificates not tested yet
    - name: /IotDpsResource/delete/DPSDelete
```
