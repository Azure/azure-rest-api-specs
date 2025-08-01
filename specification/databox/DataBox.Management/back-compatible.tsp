import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBox;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressValidationOutput.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidationResponse.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResourceUpdateParameter.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SkuInformation.properties);

@@clientLocation(JobResources.get, "Jobs");

@@clientLocation(JobResources.create, "Jobs");

@@clientName(JobResources.create::parameters.resource, "jobResource");

@@clientLocation(JobResources.update, "Jobs");

@@clientName(JobResources.update::parameters.properties,
  "jobResourceUpdateParameter"
);

@@clientLocation(JobResources.delete, "Jobs");

@@clientLocation(JobResources.listByResourceGroup, "Jobs");

@@clientLocation(JobResources.list, "Jobs");

@@clientLocation(JobResources.bookShipmentPickUp, "Jobs");

@@clientName(JobResources.bookShipmentPickUp::parameters.body,
  "shipmentPickUpRequest"
);

@@clientLocation(JobResources.cancel, "Jobs");

@@clientName(JobResources.cancel::parameters.body, "cancellationReason");

@@clientLocation(JobResources.listCredentials, "Jobs");

@@clientLocation(JobResources.markDevicesShipped, "Jobs");

@@clientName(JobResources.markDevicesShipped::parameters.body,
  "markDevicesShippedRequest"
);

@@clientName(mitigate::parameters.body, "mitigateJobRequest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResource.properties);

@@clientLocation(ServiceOperationGroup.regionConfiguration, "Service");

@@clientLocation(ServiceOperationGroup.validateAddress, "Service");

@@clientLocation(ServiceOperationGroup.validateInputs, "Service");

@@clientLocation(ServiceOperationGroup.listAvailableSkusByResourceGroup,
  "Service"
);

@@clientLocation(ServiceOperationGroup.regionConfigurationByResourceGroup,
  "Service"
);

@@clientLocation(ServiceOperationGroup.validateInputsByResourceGroup,
  "Service"
);

@@clientName(ServiceOperationGroup.regionConfiguration::parameters.body,
  "regionConfigurationRequest"
);
@@clientName(ServiceOperationGroup.validateAddress::parameters.body,
  "validateAddress"
);
@@clientName(ServiceOperationGroup.validateInputs::parameters.body,
  "validationRequest"
);

@@clientLocation(mitigate, "Management", "go");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);
