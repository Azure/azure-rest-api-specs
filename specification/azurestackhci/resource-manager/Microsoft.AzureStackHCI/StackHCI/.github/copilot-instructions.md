# Azure Stack HCI TypeSpec - Copilot Instructions

You are an expert assistant for the Azure Stack HCI TypeSpec API specification in the **private** repository (`azure-rest-api-specs-pr`).

## Project Context

- **Namespace**: `Microsoft.AzureStackHCI`
- **Language**: TypeSpec (`.tsp` files)
- **Repo type**: Private preview (superset of public repo)
- **GA version**: `v2026_02_01`
- **Preview version**: `v2026_03_15_preview` (public uses `v2026_03_01_preview`)
- **Working directory**: `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

## Key Files

| File | Purpose |
|------|---------|
| `main.tsp` | Entry point — version enum, imports, `@armProviderNamespace` |
| `models.tsp` | **ALL** model and union definitions (central file, 9000+ lines) |
| `Cluster.tsp` | Cluster resource (TrackedResource, top-level) |
| Other `*.tsp` | One file per ARM resource |
| `.agents/` | Engineering docs, style guide, changelog, workflow |

## Coding Rules

### File Structure
- TypeSpec files use **PascalCase** (except `client.tsp`, `back-compatible.tsp`, `models.tsp`)
- Only import/use what you need — no unused imports or `using` statements
- Do NOT add `@armProviderNamespace` — it's declared once in `main.tsp`
- New files must be imported in `main.tsp`

### Models
- **All models and unions go in `models.tsp`** — never in resource files
- Resource definitions (`model X is TrackedResource<...>`) stay in their own `.tsp` file
- Group related models under section comments:
  ```
  ////////////////////////////////////////////////////////////////
  ////////////////////// Feature Name Models //////////////////////
  ////////////////////////////////////////////////////////////////
  ```

### Documentation
- Use `/** JSDoc */` comments — do NOT use `@doc()` decorator
- Single-line: `/** Description. */`
- Multi-line: `/** \n * Description.\n */`

### Versioning
- New features: `@added(Versions.v2026_03_15_preview)`
- All private-preview-only features: mark with `// PRIVATE PREVIEW` comment
- Private-preview section headers use:
  ```
  ////////////////////////////////////////////////////////////////
  ////////// PRIVATE PREVIEW - Feature Name /////////////////////
  ////////////////////////////////////////////////////////////////
  ```

### Enums (Unions)
- Use `union` (not `enum`) with a `string` base type:
  ```typespec
  union MyEnum {
    string,
    /** Description. */
    Value1: "Value1",
  }
  ```

### Properties
- Read-only: `@visibility(Lifecycle.Read)`
- Optional: `propertyName?: Type`
- Provisioning state: `provisioningState?: ProvisioningState`

## Development Workflow

After any change, always run this sequence:
```
1. Edit TypeSpec files and source examples
2. npx prettier --write .\examples\{API_VERSION}\*.json
3. npx tsp compile .
4. npx oav validate-example preview/{API_VERSION}/hci.json
5. Update .agents/changelog-{API_VERSION}.md
```

### Examples
- Source examples: `examples/{API_VERSION}/*.json`
- Target (generated): `preview/{API_VERSION}/examples/*.json` (copied during compile)
- Read-only properties go in **response bodies only** (200/201), not request bodies
- When deleting examples, delete from both `examples/` and `preview/` folders

## Resource Patterns

### Proxy Resource (child of Cluster or EdgeMachine)
```typespec
@added(Versions.v2026_03_15_preview)
@parentResource(Cluster)
model MyResource is Azure.ResourceManager.ProxyResource<MyResourceProperties> {
  ...ResourceNameParameter<
    Resource = MyResource,
    KeyName = "resourceName",
    SegmentName = "resources",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface MyResources {
  get is ArmResourceRead<MyResource>;
  list is ArmResourceListByParent<MyResource>;
}
```

### Tracked Resource (top-level)
```typespec
model MyResource is Azure.ResourceManager.TrackedResource<MyResourceProperties> {
  ...ResourceNameParameter<...>;
}
```

## Reference Documentation

For detailed guidance, consult:
- `.agents/typespec-style-guide.md` — Complete style rules and code review checklist
- `.agents/development-workflow.md` — Full workflow, validation, troubleshooting
- `.agents/repo-understanding.md` — Repo structure, private vs public differences, sync process
- `.agents/changelog-2026-03-15-preview.md` — Changes in current preview version
