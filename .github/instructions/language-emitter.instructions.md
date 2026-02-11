Use this guidance whenever someone needs to add language emitters to an existing `tspconfig.yaml`, or when SDK generation fails because an emitter block is missing.

- Decide whether the service is ARM or data-plane.
- Open the matching widget `tspconfig.yaml` template.
- Copy the entire emitter block for the requested language.
- Replace every `Widget`/`widget` token with the service name and drop the block under `options:`.

## 1. Identify the service type

- Path contains `/resource-manager/` or linter references `@azure-tools/typespec-azure-rulesets/resource-manager` → ARM
- Path contains `/data-plane/` or linter references `@azure-tools/typespec-azure-rulesets/data-plane` → Data plane

## 2. Reference the official widget template

- ARM: `specification/widget/resource-manager/Microsoft.Widget/Widget/tspconfig.yaml`
- Data plane: `specification/widget/data-plane/WidgetAnalytics/tspconfig.yaml`

Always read the template before editing so you follow the canonical configuration.

## 3. Copy and customize the emitter block

- Select the entire block for the language.
- Only replace service-specific tokens (`Widget`, `widget`, namespaces, package names) with your service name.
- Leave the rest of the properties (`flavor`, boolean flags, `{service-dir}` placeholders, etc.) unchanged.

## 4. Insert into the project config

- Paste the customized block under `options:` in the target `tspconfig.yaml`, keeping YAML indentation intact.
- Confirm the `parameters:` section defines `"service-dir"` (for example `sdk/<servicename>`); add it if missing.

**Quick checks**

- Do not mix ARM and data-plane templates.
- Do not cherry-pick individual properties—copy the whole block or errors will persist.
- If the SDK pipeline still reports missing configuration, re-open the template and verify every `Widget` reference was replaced.
