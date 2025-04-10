import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthcareApis;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServicesPatchDescription.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IotDestinationProperties.provisioningState);

@@clientName(ServicesDescriptions.createOrUpdate::parameters.resource,
  "serviceDescription"
);
@@clientName(ServicesDescriptions.update::parameters.properties,
  "servicePatchDescription"
);

@@clientName(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "properties"
);
@@clientName(WorkspacePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspace");
@@clientName(Workspaces.update::parameters.properties,
  "workspacePatchResource"
);

@@clientName(DicomServices.createOrUpdate::parameters.resource, "dicomservice");
@@clientName(DicomServices.update::parameters.properties,
  "dicomservicePatchResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DicomService.properties);

@@clientName(IotConnectors.createOrUpdate::parameters.resource, "iotConnector");
@@clientName(IotConnectors.update::parameters.properties,
  "iotConnectorPatchResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IotConnector.properties);

@@clientName(IotFhirDestinations.createOrUpdate::parameters.resource,
  "iotFhirDestination"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IotFhirDestination.properties);

@@clientName(FhirServices.createOrUpdate::parameters.resource, "fhirservice");
@@clientName(FhirServices.update::parameters.properties,
  "fhirservicePatchResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FhirService.properties);
