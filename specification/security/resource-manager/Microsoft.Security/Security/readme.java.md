## Java

These settings apply only when `--java` is specified on the command line.


``` yaml $(java)
directive:
  - from: externalSecuritySolutions.json
    where: $.definitions.ExternalSecuritySolution.allOf[1]
    set:
      type: object
    reason: discriminator property is required to be defined in the model
  - from: externalSecuritySolutions.json
    where: $.definitions
    transform: $.ExternalSecuritySolution.properties = $.ExternalSecuritySolutionKind.properties
```
