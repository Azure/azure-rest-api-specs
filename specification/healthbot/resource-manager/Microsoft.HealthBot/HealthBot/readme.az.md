# AZ HealthBot

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: healthbot
    namespace: azure.mgmt.healthbot
    package-name: azure-mgmt-healthbot
az-output-folder: $(azure-cli-extension-folder)/src/healthbot
python-sdk-output-folder: "$(az-output-folder)/azext_healthbot/vendored_sdks/healthbot"
```

``` yaml 
directive:
    - where:
          group: healthbot bot
      set:
          group: healthbot

```
