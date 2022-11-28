## Java

These settings apply only when `--java` is specified on the command line.


``` yaml $(java)
directive:
  - from: ThreatIntelligence.json
    where: $.definitions.ThreatIntelligenceInformation.allOf[1]
    set:
      type: object
    reason: discriminator property is required to be defined in the model
  - from: ThreatIntelligence.json
    where: $.definitions
    transform: $.ThreatIntelligenceInformation.properties = $.ThreatIntelligenceResourceKind.properties
```
