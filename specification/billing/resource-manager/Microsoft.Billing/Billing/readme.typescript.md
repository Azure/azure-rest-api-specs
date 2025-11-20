## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-billing"
  output-folder: "$(typescript-sdks-folder)/sdk/billing/arm-billing"
  payload-flattening-threshold: 1
  generate-metadata: true

directive:
  - from: billingSavingsPlan.json
    where: $.definitions
    transform: >
      $.SavingsPlanModelListResult = {
        "type": "object",
        "description": "List of savings plans",
        "properties": {
          "value": {
            "type": "array",
            "items": {
              "$ref": "#/definitions/SavingsPlanModel"
            }
          },
          "nextLink": {
            "type": "string",
            "description": "Url to get the next page."
          },
          "summary": {
            "description": "The roll out count summary of the savings plans",
            "$ref": "#/definitions/SavingsPlanSummaryCount"
          }
        }
      }
```
