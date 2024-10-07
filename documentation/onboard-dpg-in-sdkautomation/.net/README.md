# Add TypeSpec Configuration of .Net SDK

Please copy the following configuration into `tspconfig.yaml` in your spec folder and replace `package-dir` and `namespace` to your own values.

``` yaml
  "@azure-tools/typespec-csharp":
    package-dir: "Azure.AI.Vision.Face"
    flavor: azure
    namespace: "{package-dir}"
```

- `package-dir`: Name of your package directory. It should be several parts concatenated with `.` and all the paerts should be pascal case.
- `flavor`: Always `azure` for Azure SDK.
- `namespace`: Should be the same as `package-dir`.
