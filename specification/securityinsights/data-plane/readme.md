# Security Insights

> see https://aka.ms/autorest

This is the AutoRest configuration file for SecurityInsights Data Plane API.

---

## Getting Started

To build the SDK for SecurityInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

```yaml $(tag) == 'package-2022-12'
input-file:
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/ThreatIntelligence.json
```
### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.SecurityInsights/preview/2024-02-01-preview/ThreatIntelligence.json
```

### Supressions

```yaml
directive:
  - suppress: R3023
    where: 
      - $..paths["/workspaces/{workspaceId}/threat-intelligence/indicators:upload"]
    from: ThreatIntelligence.json
    reason: This is an ARM API requirement to list all the available operations, but this is a data-plane API.

  - suppress: R4010
    where: 
      - $..paths["/workspaces/{workspaceId}/threat-intelligence/indicators:upload"]
    from: ThreatIntelligence.json
    reason: This is an ARM API requirement to have a default error response, but it is irrelevant to this data-plane API.

  - suppress: R4041
    where: 
      - $..paths["/workspaces/{workspaceId}/threat-intelligence/indicators:upload"]
    from: ThreatIntelligence.json
    reason: This API does not have array identifiers (data-plane).

  - suppress: PathForResourceAction
    where: 
      - $..paths["/workspaces/{workspaceId}/threat-intelligence/indicators:upload"]
    from: ThreatIntelligence.json
    reason: This is an ARM API naming requirement and is not relevant to a data-plane API.
```
