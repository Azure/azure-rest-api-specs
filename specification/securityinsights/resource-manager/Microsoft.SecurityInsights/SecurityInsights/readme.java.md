## Java

These settings apply only when `--java` is specified on the command line.


``` yaml $(java)
directive:
  - from: EntityTypes.json
    where: $.definitions.AccountEntityProperties.properties.ntDomain
    transform: >
      $.description = 'The NetBIOS domain name as it appears in the alert format - domain\\\\username. Examples: NT AUTHORITY.'
```
