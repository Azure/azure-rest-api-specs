# App Configuration Feature Flag

> see https://aka.ms/autorest

This self-contained TypeSpec client project generates dedicated App Configuration
Feature Flag SDK packages. The canonical App Configuration project remains
responsible for emitting the service OpenAPI document.

The Feature Flag API contract is duplicated locally to keep this SDK package
independent without cross-project TypeSpec imports. Client customizations are
defined in `client.tsp`, and language emitter settings are defined in
`tspconfig.yaml`.

---

## Configuration

```yaml
openapi-type: data-plane
```
