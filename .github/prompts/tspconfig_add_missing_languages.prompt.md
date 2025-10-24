---
mode: agent
model: Claude Sonnet 4
---

Add a language that is missing (for instance, adding Go, Python, Javascript, or C# support), using these rules:

- New emitter configurations should be added as a child of the "options:" section, after any other emitters and their options.
- Do NOT search the files in the repository for examples, as these can be out of date.
- Determine which tspconfig.yaml template to use:
  - If the currently open tspconfig.yaml contains @azure-tools/typespec-azure-rulesets/resource-manager, then use this template: [tspconfig template](https://raw.githubusercontent.com/Azure/azure-rest-api-specs/refs/heads/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml)
  - If the currently open tspconfig.yaml contains @azure-tools/typespec-azure-rulesets/data-plane, then use this template: [tspconfig template](https://raw.githubusercontent.com/Azure/azure-rest-api-specs/refs/heads/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml)
- Using the appropriate template file as a guide, add in any emitter configurations, like @azure-tools/typespec-go, that do not have emitters configured in our tspconfig.yaml.

