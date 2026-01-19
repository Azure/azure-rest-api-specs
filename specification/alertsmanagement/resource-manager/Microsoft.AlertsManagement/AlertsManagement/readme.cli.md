## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.alertsmanagement
  test-scenario:
    - name: /Alerts/get/GetById
    - name: /Alerts/get/Summary
    - name: /Alerts/get/ListAlerts
    - name: /Alerts/get/MonService
    - name: /Alerts/post/Resolve
```
