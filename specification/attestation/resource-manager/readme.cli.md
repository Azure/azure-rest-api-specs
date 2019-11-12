## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: attestation
  package-name: azure-mgmt-attestation
  namespace: azure.mgmt.attestation
  test-setup:
    - name: Operations_List
    - name: AttestationProviders_Create
    - name: AttestationProviders_Get
    - name: AttestationProviders_List
    - name: AttestationProviders_ListByResourceGroup
    - name: AttestationProviders_Delete
```
