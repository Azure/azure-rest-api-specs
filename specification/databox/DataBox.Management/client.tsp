import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBox;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AddressValidationOutput.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ValidationResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JobResourceUpdateParameter.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SkuInformation.properties);

@@clientName(JobResources.create::parameters.resource, "jobResource");
@@clientName(JobResources.update::parameters.properties,
  "jobResourceUpdateParameter"
);
@@clientName(JobResources.bookShipmentPickUp::parameters.body,
  "shipmentPickUpRequest"
);
@@clientName(JobResources.cancel::parameters.body, "cancellationReason");
@@clientName(JobResources.markDevicesShipped::parameters.body,
  "markDevicesShippedRequest"
);
@@clientName(JobResources.mitigate::parameters.body, "mitigateJobRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JobResource.properties);
