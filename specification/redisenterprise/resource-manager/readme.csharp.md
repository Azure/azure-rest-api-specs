## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  clear-output-folder: true
  client-side-validation: false
  namespace: Microsoft.Azure.Management.RedisEnterprise
  output-folder: $(csharp-sdks-folder)/redisenterprise/Microsoft.Azure.Management.RedisEnterpriseCache/src/Generated

directive:
  # Rename constants in the generated code
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /public const string Ones /g, "public const string OneSecond " ).
        replace( /public const string Oneh /g, "public const string OneHour " ).
        replace( /public const string Sixh /g, "public const string SixHours " ).
        replace( /public const string OneTwoh /g, "public const string TwelveHours " )
```
