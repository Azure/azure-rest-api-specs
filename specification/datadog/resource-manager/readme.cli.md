## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-directive:
    - where:
        group: 'RefreshSetPassword'
      name: 'set_password_link'
    - where:
        group: 'SingleSignOnConfigurations'
      name: 'sso_config'
    - where:
        group: 'Monitors'
        op: 'Create'
        param: 'monitoringStatus'
      removed: true
    - where:
        group: 'Monitors'
        op: 'Create'
        param: 'MarketplaceSubscriptionStatus'
      removed: true
    - where:
        group: 'Monitors'
        op: 'Create'
        param: 'ProvisioningState'
      removed: true
    - where:
        group: 'Monitors'
        op: 'Update'
        param: 'monitoringStatus'
      removed: true
```
