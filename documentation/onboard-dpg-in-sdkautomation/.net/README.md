# Add TypeSpec Configuration of .Net SDK

Please copy the following configuration into `tspconfig.yaml` in your spec folder and replace `package-dir` and `namespace` to your own values.

``` yaml
  "@azure-tools/typespec-csharp":
    package-dir: "Azure.AI.Vision.Face"
    flavor: azure
    namespace: "{package-dir}"
```
- `package-dir`: Name of your package directory.
- `flavor`: Always `azure` for Azure SDK.
- `namespace`: Namespace of your generated SDK.
