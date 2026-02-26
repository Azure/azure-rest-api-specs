# TypeSpec Customization Detailed Steps

## Setting Up client.tsp

Ensure `client.tsp` exists in the project root with:
```typespec
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
using Azure.ClientGenerator.Core;
```
Add `namespace ClientCustomizations;` if defining new types.

## Decorator Patterns

**Rename for SDK:** `@@clientName(ServiceType, "SDKName")`
**Language-specific:** `@@clientName(foo, "pythonicFoo", "python")`
**Exclude from language:** `@@scope(Foo.create, "!csharp")`
**Control access:** `@@access(getFoo, Access.internal)`
**Move operations:** `@@clientLocation(MyService.upload, AdminOperations)`

## Scope Best Practices

- Use negation for single-language exclusions: `"!csharp"`
- Combine scopes when logic is identical: `"python, go"`
- No scope = all languages

## Decision Flow

```
Need to customize SDK?
→ Can it be done in TypeSpec?
  → Yes: Use client.tsp decorators (this skill)
  → No: Use language-specific code customization guides
```

## Language-Specific Code Customization (when TypeSpec isn't enough)

| Language | Guide |
|----------|-------|
| C# | Partial classes with `[CodeGenType]` attributes |
| Python | `_patch.py` files at models, operations, client levels |
| Java | `Customization` class with `customizeAst()` method |
| JavaScript | Copy `src/` to `generated/`, add customizations in `src/` |
| Go | Custom wrapper files for advanced cases |
