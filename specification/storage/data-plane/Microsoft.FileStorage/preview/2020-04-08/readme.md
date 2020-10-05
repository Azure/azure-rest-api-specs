# Storage Dataplane

> see https://aka.ms/autorest

``` yaml
input-file: ./file.json
azure-validator: true
openapi-type: data-plane

directive:
  # These directives are suppressed but do not block generating documentation
  - suppress: R3016 # Properties must be camelCase
  - suppress: R2058 # Paths in x-ms-paths must overload a normal path in the paths section, i.e. a path in the x-ms-paths must either be same as
                    # a path in the paths section or a path in the paths sections followed by additional parameters.

  # These directives are temporarily suppressed. They should be removed from this file before Swaggers can be used to generate documentation. The Swaggers can still be used to generate code with these directives suppressed. Tracking with work item #2181761.
  - suppress: R2022 # Add x-ms-examples
  - suppress: R2003 # etag / url is not a known format
  - suppress: R4000 # Missing description
  - suppress: R4001 # url defined in global param without extension
  - suppress: D5001 # x-ms-examples describing minimum/maximum property set for response/request payloads for operations

  # Errors being temporarily suppressed while we work on swagger improvements in our fork
  - suppress: UNREFERENCED_JSON_FILE # This is because of the top level DataLake readme
  - where: $["x-ms-paths"][*][*]
    suppress:
      - MISSING_PATH_PARAMETER_DEFINITION # Storage generators ignore path parameters so they're not in the swagger
```
