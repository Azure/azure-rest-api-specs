import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthcareApis;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServicesPatchDescription.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IotDestinationProperties.provisioningState);

@@clientLocation(ServicesDescriptions.get, "Services");
@@clientLocation(ServicesDescriptions.createOrUpdate, "Services");
@@clientName(ServicesDescriptions.createOrUpdate::parameters.resource,
  "serviceDescription"
);
@@clientLocation(ServicesDescriptions.update, "Services");
@@clientName(ServicesDescriptions.update::parameters.properties,
  "servicePatchDescription"
);
@@clientLocation(ServicesDescriptions.delete, "Services");
@@clientLocation(ServicesDescriptions.listByResourceGroup, "Services");
@@clientLocation(ServicesDescriptions.list, "Services");

@@clientLocation(PrivateEndpointConnectionDescriptions.get,
  "PrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnectionDescriptions.createOrUpdate,
  "PrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "properties"
);
@@clientLocation(PrivateEndpointConnectionDescriptions.delete,
  "PrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnectionDescriptions.listByService,
  "PrivateEndpointConnections"
);
@@clientName(WorkspacePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);

@@clientLocation(PrivateLinkResourceDescriptions.get, "PrivateLinkResources");
@@clientLocation(PrivateLinkResourceDescriptions.listByService,
  "PrivateLinkResources"
);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspace");
@@clientName(Workspaces.update::parameters.properties,
  "workspacePatchResource"
);

@@clientName(DicomServices.createOrUpdate::parameters.resource, "dicomservice");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DicomService.properties);

@@clientName(IotConnectors.createOrUpdate::parameters.resource, "iotConnector");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IotConnector.properties);

@@clientLocation(IotFhirDestinations.get, "IotConnectorFhirDestination");
@@clientLocation(IotFhirDestinations.createOrUpdate,
  "IotConnectorFhirDestination"
);
@@clientName(IotFhirDestinations.createOrUpdate::parameters.resource,
  "iotFhirDestination"
);
@@clientLocation(IotFhirDestinations.delete, "IotConnectorFhirDestination");
@@clientLocation(IotFhirDestinations.listByIotConnector, "FhirDestinations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IotFhirDestination.properties);

@@clientName(FhirServices.createOrUpdate::parameters.resource, "fhirservice");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FhirService.properties);

@@clientLocation(ServicesOperationGroup.checkNameAvailability, "Services");

@@clientLocation(OperationResultsOperationGroup.get, "OperationResults");

@@clientName(ServicesOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInputs"
);

@@clientLocation(DicomServiceOperationGroup.delete, "DicomServices");
@@clientLocation(DicomServiceOperationGroup.update, "DicomServices");
@@clientLocation(FhirServiceOperationGroup.delete, "FhirServices");
@@clientLocation(FhirServiceOperationGroup.update, "FhirServices");
@@clientLocation(IotConnectorOperationGroup.delete, "IotConnectors");
@@clientLocation(IotConnectorOperationGroup.update, "IotConnectors");
