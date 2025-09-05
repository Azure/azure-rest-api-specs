import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBox;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressValidationOutput.properties, "!csharp");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidationResponse.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResourceUpdateParameter.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SkuInformation.properties);

@@clientLocation(JobResources.get, "Jobs", "!csharp");

@@clientLocation(JobResources.create, "Jobs", "!csharp");

@@clientName(JobResources.create::parameters.resource, "jobResource");

@@clientLocation(JobResources.update, "Jobs", "!csharp");

@@clientName(JobResources.update::parameters.properties,
  "jobResourceUpdateParameter"
);

@@clientLocation(JobResources.delete, "Jobs", "!csharp");

@@clientLocation(JobResources.listByResourceGroup, "Jobs", "!csharp");

@@clientLocation(JobResources.list, "Jobs", "!csharp");

@@clientLocation(JobResources.bookShipmentPickUp, "Jobs", "!csharp");

@@clientName(JobResources.bookShipmentPickUp::parameters.body,
  "shipmentPickUpRequest"
);

@@clientLocation(JobResources.cancel, "Jobs", "!csharp");

@@clientName(JobResources.cancel::parameters.body, "cancellationReason");

@@clientLocation(JobResources.listCredentials, "Jobs", "!csharp");

@@clientLocation(JobResources.markDevicesShipped, "Jobs", "!csharp");

@@clientName(JobResources.markDevicesShipped::parameters.body,
  "markDevicesShippedRequest"
);

@@clientName(mitigate::parameters.body, "mitigateJobRequest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResource.properties);

@@clientLocation(ServiceOperationGroup.regionConfiguration,
  "Service",
  "!csharp"
);

@@clientLocation(ServiceOperationGroup.validateAddress, "Service", "!csharp");

@@clientLocation(ServiceOperationGroup.validateInputs, "Service", "!csharp");

@@clientLocation(ServiceOperationGroup.listAvailableSkusByResourceGroup,
  "Service",
  "!csharp"
);

@@clientLocation(ServiceOperationGroup.regionConfigurationByResourceGroup,
  "Service",
  "!csharp"
);

@@clientLocation(ServiceOperationGroup.validateInputsByResourceGroup,
  "Service",
  "!csharp"
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
