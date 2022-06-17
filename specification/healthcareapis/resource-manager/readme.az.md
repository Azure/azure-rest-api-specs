# AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: healthcareapis
    namespace: azure.mgmt.healthcareapis
    package-name: azure-mgmt-healthcareapis
az-output-folder: $(azure-cli-extension-folder)/src/healthcareapis
python-sdk-output-folder: "$(az-output-folder)/azext_healthcareapis/vendored_sdks/healthcareapis"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
extension-mode: stable

# rename command groups
directive:
    - where:
          group: healthcareapis workspace-private-endpoint-connection
      set:
          group: healthcareapis workspace private-endpoint-connection
    - where:
          group: healthcareapis workspace-private-link-resource
      set: 
          group: healthcareapis workspace private-link-resource
    - where:
          group: healthcareapis dicom-service
      set: 
          group: healthcareapis workspace dicom-service
    - where:
          group: healthcareapis fhir-service
      set: 
          group: healthcareapis workspace fhir-service
    - where:
          group: healthcareapis iot-connector
      set: 
          group: healthcareapis workspace iot-connector
    - where:
          group: healthcareapis iot-connector-fhir-destination
      set: 
          group: healthcareapis workspace iot-connector fhir-destination
    - where:
          group: healthcareapis fhir-destination
      set: 
          group: healthcareapis workspace iot-connector fhir-destination
```
