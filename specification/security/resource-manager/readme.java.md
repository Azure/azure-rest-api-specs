## Java

These settings apply only when `--java` is specified on the command line.


``` yaml $(java)
directive:
  - from: externalSecuritySolutions.json
    where: $.definitions.ExternalSecuritySolution.allOf[1]
    set:
      type: object
      description: 'Describes an Azure resource with location'
    reason: discriminator property is required to be defined in the model
  - from: externalSecuritySolutions.json
    where: $.definitions.ExternalSecuritySolution.properties
    set:
      kind:
        type: object
        description: 'Describes an Azure resource with kind'
        enum:
          - CEF
          - ATA
          - AAD
        x-ms-enum:
          name: ExternalSecuritySolutionKind
          modelAsString: true
```
