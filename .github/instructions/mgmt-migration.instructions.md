- DO extend the `@azure-tools/typespec-azure-rulesets/resource-manager` linter rule set in your tspconfig.yaml. Example:

```yaml title=tspconfig.yaml
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
```

- A good example of a well structured management plane spec is the ../../specification/contosowidgetmanager/Contoso.Management/ spec. Use this as a reference for your own spec.

I've recently converted my swagger specification to typespec, can you go through the files of my project and make sure they're following the initial migration checklist?
