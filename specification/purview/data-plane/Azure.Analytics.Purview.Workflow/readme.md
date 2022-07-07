

## Configuration

### Basic Information

These are the global settings for the Azure Purview Workflow API.

``` yaml
openapi-type: data-plane
tag: package-2022-05-01-preview
```

### Tag: package-2022-05-01-preview

These settings apply only when `--tag=package-2022-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-05-01-preview'
input-file:
- Azure.Analytics.Purview.Workflow/preview/2022-05-01-preview/purviewWorkflow.json
```

## Suppression
``` yaml
directive:
  - suppress: R3006
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Currently systemData is not allowed.
```

``` yaml
directive:
  - suppress: R2020
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Workflow definition is not a resource.
```

``` yaml
directive:
  - suppress: R3023
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: No operations endpoint as not ARM resource provider.
```


``` yaml
directive:
  - suppress: R2062
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: Workflow is not ARM resource.
```

``` yaml
directive:
  - suppress: R4011
where:
  - $.definitions.WorkflowDefinition.properties
from: purviewWorkflow.json
reason: The delete workflow definition operation have the required responses.
```