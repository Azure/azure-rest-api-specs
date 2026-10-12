# Widget Management conversion fixture

> see https://aka.ms/autorest

This minimal ARM API is a self-contained input for the `tsp-client convert` smoke
test. Keep its definitions local rather than referencing the repository's
`specification/` tree.

```yaml
openapi-type: arm
openapi-subtype: rpaas
namespace: Test.WidgetManagement
tag: package-2026-01-01
```

```yaml $(tag) == 'package-2026-01-01'
input-file:
  - widgets.json
```
