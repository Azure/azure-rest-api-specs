import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBox;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SkuInformation.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressValidationOutput.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidationResponse.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResourceUpdateParameter.properties);

@@clientName(JobResources.create::parameters.resource, "jobResource");
@@clientName(JobResources.update::parameters.properties,
  "jobResourceUpdateParameter"
);
@@clientName(JobResources.markDevicesShipped::parameters.body,
  "markDevicesShippedRequest"
);
@@clientName(JobResources.bookShipmentPickUp::parameters.body,
  "shipmentPickUpRequest"
);
@@clientName(JobResources.cancel::parameters.body, "cancellationReason");
@@clientName(JobResources.mitigate::parameters.body, "mitigateJobRequest");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobResource.properties);

@@clientName(ServiceOperationGroup.regionConfiguration::parameters.body,
  "regionConfigurationRequest"
);
@@clientName(ServiceOperationGroup.validateAddress::parameters.body,
  "validateAddress"
);
@@clientName(ServiceOperationGroup.validateInputs::parameters.body,
  "validationRequest"
);
