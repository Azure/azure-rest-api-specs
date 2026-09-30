## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.maintenance
  flatten-all: true
  cli-directive:
      - select: 'operationGroup'
        where:
            operationGroup: 'ApplyUpdateForResourceGroup'
        hidden: true
      - where:
            operationGroup: 'MaintenanceConfigurationsForResourceGroup'
        hidden: true
      - where:
            operationGroup: 'ConfigurationAssignmentsWithinSubscription'
        hidden: true
      - select: 'parameter'
        where:
          parameter: duration
        alias:
          - maintenance-window-duration
          - duration
      - where:
          parameter: 'expirationDateTime'
        alias:
          - maintenance-window-expiration-date-time
          - expiration-date-time
      - where:
          parameter: 'recurEvery'
        alias:
          - maintenance-window-recur-every
          - recur-every
      - where:
          param: startDateTime
        alias:
          - maintenance-window-start-date-time
          - start-date-time
      - where:
          param: timeZone
        alias:
          - maintenance-window-time-zone
          - time-zone
      - where:
          param: linuxParameters
        alias:
          - install-patches-linux-parameters
          - linux-parameters
      - where:
          param: windowsParameters
        alias:
          - install-patches-windows-parameters
          - windows-parameters
      - where:
          param: postTasks
        alias:
          - install-patches-post-tasks
          - post-tasks       
      - where:
          param: preTasks
        alias:
          - install-patches-pre-tasks
          - pre-tasks          
```
