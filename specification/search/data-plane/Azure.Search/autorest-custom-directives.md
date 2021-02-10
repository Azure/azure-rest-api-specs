```yaml
# Declare a directive that can be invoked in the pipeline
declare-directive:

  # Renames a property in the given path
  rename-custom-property: >-
    {
      from: 'swagger-document',
      where: $.path,
      transform: `$.name = $.name === "${$.from}" ? "${$.to}" : $.name`
    }

  # Change from object reference to string
  change-object-ref-to-string: >-
    {
      from: 'swagger-document',
      where: $.path,
      transform: `delete $['$ref']; $['type'] = "string"`
    }
```
