## AZ
These settings apply only when `--az` is specified on the command line.
``` yaml $(az)
az:
    extensions: timeseriesinsights
    namespace: azure.mgmt.timeseriesinsights
    package-name: azure-mgmt-timeseriesinsights
az-output-folder: $(azure-cli-extension-folder)/src/timeseriesinsights
python-sdk-output-folder: "$(az-output-folder)/azext_timeseriesinsights/vendored_sdks/timeseriesinsights"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

# Az.TimeSeriesInsights
This directory contains the Cli common model for the TimeSeriesInsights service.

> Metadata
``` yaml
# Migrated from Powershell's readme

extension-mode: experimental

cli:
    cli-directive:
      - where:
            group: 'Environments'
            op: 'CreateOrUpdate'
            param: 'parameters'
        poly-resource: true
      - where:
            group: 'EventSources'
            op: 'CreateOrUpdate'
            param: 'parameters'
        poly-resource: true
```