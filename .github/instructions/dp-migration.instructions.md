- DO extend the `@azure-tools/typespec-azure-rulesets/data-plane` linter rule set in your tspconfig.yaml. Example:

```yaml title=tspconfig.yaml
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
```

- A good example of a well structured data plane spec is the ../../specification/contosowidgetmanager/Contoso.WidgetManager/ spec. Use this as a reference for your own spec.
- Avoid importing or using templates from the `@azure-tools/typespec-azure-resource-manager` library in a data-plane specification

I've recently converted my swagger specification to typespec, can you go through the files of my project and make sure they're following the initial migration checklist?
