# Suppression Test - No Reason

> see https://aka.ms/autorest

```yaml
openapi-type: arm
tag: package-2025-01-01
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - Microsoft.WidgetManager/stable/2025-01-01/widgetmanager.json
directive:
  - suppress: AvoidAdditionalProperties
    where: $.definitions.Widget.properties.tags
  - suppress: PatchBodyParametersSchema
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.WidgetManager/widgets/{widgetName}"].patch
```
