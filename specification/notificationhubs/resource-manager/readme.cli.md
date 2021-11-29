## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.notificationhubs
  flatten-all: true
  test-scenario:
    - name: NameSpaceCreate
    - name: NotificationHubCreate
  cmd-override:
    "^notificationhubs$": "* namespace"
    "^notificationhubs notification-hub$": "* hub"
```
