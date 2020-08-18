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
            group: profile
            param: cold_path_sampling_percentage_rate
        alias:
          - sample_rate_cold
      - where:
            group: profile
            param: start_delay_milliseconds
        alias:
          - start_delay_ms
      - where:
            group: measurement-endpoint
            param: hot_path_sampling_percentage_rate
        alias:
          - sample_rate_hot
      - where:
            group: measurement-endpoint
            param: warm_path_sampling_percentage_rate
        alias:
          - sample_rate_warm
      - where:
            group: measurement-endpoint
            param: cold_path_sampling_percentage_rate_override
        alias:
          - sample_rate_cold
      - where:
            group: measurement-endpoint-condition
            param: measurement_endpoint_name
        alias:
          - endpoint_name
```