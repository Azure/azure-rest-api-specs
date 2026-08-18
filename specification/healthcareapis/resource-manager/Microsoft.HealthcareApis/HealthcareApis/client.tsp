import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;

namespace Microsoft.HealthcareApis;

@@clientName(
  Microsoft.HealthcareApis,
  "HealthcareApisManagementClient",
  "python,javascript"
);
@@clientLocation(DicomServiceOperationGroup.delete, DicomServices, "python");
@@clientLocation(DicomServiceOperationGroup.update, DicomServices, "python");
@@clientLocation(FhirServiceOperationGroup.delete, FhirServices, "python");
@@clientLocation(FhirServiceOperationGroup.update, FhirServices, "python");
@@clientLocation(IotConnectorOperationGroup.delete, IotConnectors, "python");
@@clientLocation(IotConnectorOperationGroup.update, IotConnectors, "python");
@@clientName(
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType,
  "ArmManagedServiceIdentityType",
  "python,javascript,go,java"
);
@@alternateType(DicomService.etag, Azure.Core.eTag, "csharp");
@@alternateType(IotConnector.etag, Azure.Core.eTag, "csharp");
@@alternateType(Workspace.etag, Azure.Core.eTag, "csharp");
@@alternateType(ServicesDescription.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  ServiceManagedIdentity.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ServicesDescription.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(ServicesDescription, "HealthcareApisService", "csharp");
@@clientName(ProvisioningState, "HealthcareApisProvisioningState", "csharp");
@@clientName(
  PublicNetworkAccess,
  "HealthcareApisPublicNetworkAccess",
  "csharp"
);
@@clientName(ServiceEventState, "FhirServiceEventState", "csharp");
@@clientName(ActionType, "OperationActionType", "csharp");
@@clientName(
  CheckNameAvailabilityParameters,
  "HealthcareApisNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters.type, "ResourceType", "csharp");
@@alternateType(
  CheckNameAvailabilityParameters.type,
  armResourceType,
  "csharp"
);
@@clientName(
  ServicesNameAvailabilityInfo,
  "HealthcareApisNameAvailabilityResult",
  "csharp"
);
@@clientName(
  ServicesNameAvailabilityInfo.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  ServiceNameUnavailabilityReason,
  "HealthcareApisNameUnavailableReason",
  "csharp"
);
@@clientName(ResourceTags, "HealthcareApisResourceTags", "csharp");
@@access(DicomServiceCollection, Access.internal, "csharp");
@@access(FhirServiceCollection, Access.internal, "csharp");
@@access(IotConnectorCollection, Access.internal, "csharp");
@@access(IotFhirDestinationCollection, Access.internal, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DicomService,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  FhirService,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IotConnector,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Workspace,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DicomServicePatchResource,
  ResourceTags,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  FhirServicePatchResource,
  ResourceTags,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IotConnectorPatchResource,
  ResourceTags,
  "csharp"
);
@@clientName(ServicesProperties, "HealthcareApisServiceProperties", "csharp");
@@clientName(
  ServiceAccessPolicyEntry,
  "HealthcareApisServiceAccessPolicyEntry",
  "csharp"
);
@@clientName(
  ServiceAcrConfigurationInfo,
  "HealthcareApisServiceAcrConfiguration",
  "csharp"
);
@@clientName(
  ServiceAuthenticationConfigurationInfo,
  "HealthcareApisServiceAuthenticationConfiguration",
  "csharp"
);
@@clientName(
  ServiceCorsConfigurationInfo,
  "HealthcareApisServiceCorsConfiguration",
  "csharp"
);
@@clientName(
  ServiceCosmosDbConfigurationInfo,
  "HealthcareApisServiceCosmosDbConfiguration",
  "csharp"
);
@@clientName(
  ServiceImportConfigurationInfo,
  "HealthcareApisServiceImportConfiguration",
  "csharp"
);
@@clientName(
  ServiceOciArtifactEntry,
  "HealthcareApisServiceOciArtifactEntry",
  "csharp"
);
@@clientName(ServicesDescriptions, "HealthcareApisServices", "csharp");
@@clientName(Workspace, "HealthcareApisWorkspace", "csharp");
@@clientName(
  WorkspaceProperties,
  "HealthcareApisWorkspaceProperties",
  "csharp"
);
@@clientName(Workspaces, "HealthcareApisWorkspaces", "csharp");
@@clientName(
  PrivateEndpointConnectionDescription,
  "HealthcareApisPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionDescriptions,
  "HealthcareApisServicePrivateEndpointConnections",
  "csharp"
);
@@clientName(
  WorkspacePrivateEndpointConnections,
  "HealthcareApisWorkspacePrivateEndpointConnections",
  "csharp"
);
@@clientName(
  PrivateLinkResourceDescription,
  "HealthcareApisPrivateLinkResource",
  "csharp"
);
@@clientName(
  PrivateLinkResourceDescriptions,
  "HealthcareApisServicePrivateLinkResources",
  "csharp"
);
@@clientName(
  WorkspacePrivateLinkResources,
  "HealthcareApisWorkspacePrivateLinkResources",
  "csharp"
);
@@clientName(IotConnector, "HealthcareApisIotConnector", "csharp");
@@clientName(
  IotEventHubIngestionEndpointConfiguration,
  "HealthcareApisIotConnectorEventHubIngestionConfiguration",
  "csharp"
);
@@clientName(
  IotIdentityResolutionType,
  "HealthcareApisIotIdentityResolutionType",
  "csharp"
);
@@clientName(
  IotMappingProperties,
  "HealthcareApisIotMappingProperties",
  "csharp"
);
@@clientName(
  IotConnectorProperties,
  "HealthcareApisIotConnectorProperties",
  "csharp"
);
@@clientName(
  IotConnectorCollection,
  "HealthcareApisIotConnectorCollection",
  "csharp"
);
@@clientName(IotConnectors, "HealthcareApisIotConnectors", "csharp");
@@clientName(IotFhirDestination, "HealthcareApisIotFhirDestination", "csharp");
@@clientName(
  IotFhirDestinationProperties,
  "HealthcareApisIotFhirDestinationProperties",
  "csharp"
);
@@clientName(
  IotFhirDestinationCollection,
  "HealthcareApisIotFhirDestinationCollection",
  "csharp"
);
@@clientName(
  IotFhirDestinations,
  "HealthcareApisIotFhirDestinations",
  "csharp"
);
@@clientName(CorsConfiguration, "DicomServiceCorsConfiguration", "csharp");
@@clientName(
  ResourceVersionPolicyConfiguration,
  "FhirServiceResourceVersionPolicyConfiguration",
  "csharp"
);
@@clientName(
  StorageConfiguration,
  "HealthcareApisServiceStorageConfiguration",
  "csharp"
);
@@clientName(SmartDataActions, "SmartDataAction", "csharp");
@@clientName(
  DicomServiceProperties.enableDataPartitions,
  "IsDataPartitionsEnabled",
  "csharp"
);
@@clientName(
  FhirServiceAuthenticationConfiguration.smartProxyEnabled,
  "IsSmartProxyEnabled",
  "csharp"
);
@@clientName(FhirServiceImportConfiguration.enabled, "IsEnabled", "csharp");
@@clientName(
  FhirServiceImportConfiguration.initialImportMode,
  "IsInitialImportMode",
  "csharp"
);
@@clientName(
  ImplementationGuidesConfiguration.usCoreMissingData,
  "IsUsCoreMissingDataEnabled",
  "csharp"
);
@@clientName(
  EncryptionCustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  "KeyEncryptionKeyUri",
  "csharp"
);
@@clientName(
  MetricDimension.toBeExportedForShoebox,
  "IsExportedForShoebox",
  "csharp"
);
@@clientName(
  MetricSpecification.fillGapWithZero,
  "IsFillGapWithZero",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mitigate C# breaking change from Swagger to TypeSpec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateEndpointConnectionDescription.properties,
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(
  EncryptionCustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  url,
  "csharp"
);
@@alternateType(DicomServiceProperties.serviceUrl, url, "csharp");
@@alternateType(
  Azure.ResourceManager.CommonTypes.PrivateEndpoint.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DicomServiceProperties.privateEndpointConnections,
  PrivateEndpointConnectionDescription[],
  "csharp"
);
@@alternateType(
  FhirServiceProperties.privateEndpointConnections,
  PrivateEndpointConnectionDescription[],
  "csharp"
);
@@alternateType(
  ServicesProperties.privateEndpointConnections,
  PrivateEndpointConnectionDescription[],
  "csharp"
);
@@alternateType(
  WorkspaceProperties.privateEndpointConnections,
  PrivateEndpointConnectionDescription[],
  "csharp"
);
@@alternateType(
  IotFhirDestinationProperties.fhirServiceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@access(IotMappingProperties, Access.public, "csharp");
@@clientName(IotFhirDestinationProperties.fhirMapping, "FhirMapping", "csharp");
@@alternateType(
  IotFhirDestinationProperties.fhirMapping,
  IotMappingProperties,
  "csharp"
);
@@clientName(
  ServicesOperationGroup.checkNameAvailability,
  "CheckHealthcareApisNameAvailability",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.markAsPageable decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateLinkResourceDescriptions.listByService,
  "csharp"
);
@@usage(PrivateLinkResourceDescription, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateLinkResourceDescription.properties,
  "csharp"
);
@@alternateType(
  PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  PrivateEndpointConnectionDescription,
  "csharp"
);
@@alternateType(
  WorkspacePrivateEndpointConnections.createOrUpdate::parameters.resource,
  PrivateEndpointConnectionDescription,
  "csharp"
);
@@clientName(
  ServiceAuthenticationConfigurationInfo.smartProxyEnabled,
  "IsSmartProxyEnabled",
  "csharp"
);
@@clientName(ServiceImportConfigurationInfo.enabled, "IsEnabled", "csharp");
@@clientName(
  ServiceImportConfigurationInfo.initialImportMode,
  "IsInitialImportMode",
  "csharp"
);
@@clientLocation(
  PrivateEndpointConnectionDescriptions.get,
  "HealthcareApisServicePrivateEndpointConnections",
  "csharp"
);
@@clientLocation(
  PrivateEndpointConnectionDescriptions.createOrUpdate,
  "HealthcareApisServicePrivateEndpointConnections",
  "csharp"
);
@@clientLocation(
  PrivateEndpointConnectionDescriptions.delete,
  "HealthcareApisServicePrivateEndpointConnections",
  "csharp"
);
@@clientLocation(
  PrivateEndpointConnectionDescriptions.listByService,
  "HealthcareApisServicePrivateEndpointConnections",
  "csharp"
);
@@clientLocation(
  PrivateLinkResourceDescriptions.get,
  "HealthcareApisServicePrivateLinkResources",
  "csharp"
);
@@clientLocation(
  PrivateLinkResourceDescriptions.listByService,
  "HealthcareApisServicePrivateLinkResources",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mitigate Java breaking change from Swagger to TypeSpec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateEndpointConnectionDescription.properties,
  "java,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mitigate Java breaking change from Swagger to TypeSpec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateLinkResourceDescription.properties,
  "java,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Mitigate Java breaking change from Swagger to TypeSpec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection.properties,
  "java,javascript"
);
