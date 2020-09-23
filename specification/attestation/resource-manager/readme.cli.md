## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: attestation
  package-name: azure-mgmt-attestation
  namespace: azure.mgmt.attestation
  test-scenario:
    - name: /AttestationProviders/put/AttestationProviders_Create
    - name: /AttestationProviders/get/AttestationProviders_Get
    - name: /AttestationProviders/get/AttestationProviders_ListByResourceGroup
    - name: /AttestationProviders/get/AttestationProviders_List
    - name: /Operations/get/Operations_List
    - name: /AttestationProviders/patch/AttestationProviders_Update
    - name: /AttestationProviders/delete/AttestationProviders_Delete
```
