---
applyTo: '**/tspconfig.yaml'
---

## Adding a missing language

If I want to add a language that is missing, follow these rules:
- Use only the tspconfig.yaml being edited and the template file given as references. 
- Do not search the files in the repository as those are possibly outdated.
- Using #../../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml as a guide, add in any languages that do not have emitters configured in our tspconfig.yaml.
- Additionally, if any existing emitters are using _different_ attributes than the ones in the template, add those in as well but make it clear those are suggestions with a comment that says "// TODO: verify this attribute should be added".
