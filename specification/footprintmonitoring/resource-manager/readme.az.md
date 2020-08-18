## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: footprint
    namespace: azure.mgmt.footprint
    package-name: azure-mgmt-footprint
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/footprint
python-sdk-output-folder: "$(az-output-folder)/azext_footprint/vendored_sdks/footprint"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details

cli:
    cli-directive:
      - where:
            group: profiles
            param: coldPathSamplingPercentageRate
        alias:
          - sample_rate_cold
      - where:
            group: profiles
            param: startDelayMilliseconds
        alias:
          - start_delay_ms
      - where:
            group: measurementEndpoints
            param: hotPathSamplingPercentageRate
        alias:
          - sample_rate_hot
      - where:
            group: measurementEndpoints
            param: warmPathSamplingPercentageRate
        alias:
          - sample_rate_warm
      - where:
            group: measurementEndpoints
            param: coldPathSamplingPercentageRateOverride
        alias:
          - sample_rate_cold
      - where:
            group: measurementEndpointConditions
            param: measurementEndpointName
        alias:
          - endpoint_name
      - where:
            group: measurementEndpointConditions
            param: conditionName
        alias:
          - name
```