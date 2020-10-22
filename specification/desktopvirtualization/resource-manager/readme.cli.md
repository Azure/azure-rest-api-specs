## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml $(cli)
cli:
  cli-name: desktopvirtualization
  cli-directive:
    - where:
        group: (ActiveApplications|Applications|ApplicationgroupAssignments|Desktops|SessionHosts|StartMenuItems|UserSessions)
      hidden: true
    # - where:
    #     group: ApplicationGroups
    #     op: ListByResourceGroup
    #     param: \$filter
    #   name: list-filter
```
