## CLI

These settings apply only when `--cli` is specified on the command line.

```yaml $(cli)
cli:
  cli-name: domainregistration
  package-name: azure-mgmt-domainregistration
  namespace: azure.mgmt.domainregistration
  test-scenario:
    - name: /TopLevelDomains/get/Get Top Level Domain
      disabled: true
    - name: /TopLevelDomains/get/List Top Level Domains
      disabled: true
    - name: /DomainRegistrationProvider/get/List operations
    - name: /Domains/post/Renew an existing domain
      disabled: true
    - name: /TopLevelDomains/post/List Top Level Domain Agreements
      disabled: true
```
