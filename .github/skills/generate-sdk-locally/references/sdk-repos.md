# SDK Repository Details

## Language Repository Mapping

| Language | Repository |
|----------|-----------|
| .NET | `azure-sdk-for-net` |
| Java | `azure-sdk-for-java` |
| JavaScript | `azure-sdk-for-js` |
| Python | `azure-sdk-for-python` |
| Go | `azure-sdk-for-go` |

## Configuration File Paths

- **From azure-rest-api-specs repo:** Use path to `tspconfig.yaml`
- **From SDK language repo:** Use path to `tsp-location.yaml`

## Build Failure Resolution

If build fails:
- Check for TypeSpec customization needs → use `typespec-customization` skill
- Regenerate SDK after fixing issues
