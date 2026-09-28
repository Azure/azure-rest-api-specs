# Widget

> see https://aka.ms/autorest

This is the AutoRest configuration file for Widget.

## Authoring and assessment test baseline

The employee state-update scenario is restored from commit
`b83d8cc958c0a142d0d8baebc479dbd6dfb42a37` for local testing. Both
`2021-11-01` and `2024-10-01-preview` expose `Employees_UpdateState`.
Its request model, `UpdateEmployeeState`, inherits optional `dryRun` from
`EmployeeActionConfig` and adds optional `enabled`. It intentionally retains a
scoped `composition-over-inheritance` suppression and has no `reason` property.

Use this prompt to exercise the authoring and assessment workflow:

> Help me fix the suppression first, then add an optional reason to the employee
> state-update action, so callers can explain why they are enabling or disabling
> an employee.

For a repeatable comparison against `HEAD`, commit this baseline separately
before making the demo changes. Baseline creation does not itself create a
commit. Confirm the comparison baseline when running assessment.

The intended compatible change adds `reason?: string` only to the preview API
and preserves the public SDK inheritance relationship. Replacing `extends`
with a spread is a negative test: it preserves the wire properties but removes
the nominal inheritance relationship, which downstream assessment should detect.
Fast assessment requires the planned skill integration to be implemented first.

## Configuration

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2024-10-01
```

### Tag: package-preview-2024-10-01

These settings apply only when `--tag=package-preview-2024-10-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10-01'
input-file:
  - preview/2024-10-01-preview/widget.json
suppressions:
  - code: PathContainsResourceType
  - code: PathResourceProviderMatchNamespace
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - stable/2021-11-01/widget.json
suppressions:
  - code: PathContainsResourceType
  - code: PathResourceProviderMatchNamespace
```

---
