import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.SignalRService;

@TypeSpec.Versioning.useDependency(
  Microsoft.SignalRService.Versions.v2025_01_01_preview
)
namespace Customization;

@@clientName(Microsoft.SignalRService, "SignalRManagementClient", "python");
@@clientName(Microsoft.SignalRService, "SignalRManagementClient", "javascript");

// Client name mappings to match the existing Java SDK naming conventions
@@clientName(NetworkACL, "NetworkAcl", "java");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "java");
@@clientName(ACLAction, "AclAction", "java");

// Property name mappings to maintain backward compatibility
@@clientName(SignalRProperties.externalIP, "externalIp", "java");
@@clientName(SignalRProperties.hostName, "hostname", "java");
@@clientName(SignalRProperties.hostNamePrefix, "hostnamePrefix", "java");

// Override the order of path parameters
#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<PrivateEndpointConnection>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,
): PrivateEndpointConnection;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<PrivateEndpointConnection>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @body
  parameters: PrivateEndpointConnection,
): PrivateEndpointConnection;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<PrivateEndpointConnection>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,
): void;

@@override(
  PrivateEndpointConnections.get,
  SignalRPrivateEndpointConnectionsGetCustomized,
  "java,go,python,javascript"
);
@@override(
  PrivateEndpointConnections.update,
  SignalRPrivateEndpointConnectionsUpdateCustomized,
  "java,go,python,javascript"
);
@@override(
  PrivateEndpointConnections.delete,
  SignalRPrivateEndpointConnectionsDeleteCustomized,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<SharedPrivateLinkResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  sharedPrivateLinkResourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @body
  parameters: SharedPrivateLinkResource,
): SharedPrivateLinkResource;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<SharedPrivateLinkResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  sharedPrivateLinkResourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,
): SharedPrivateLinkResource;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<SharedPrivateLinkResource>,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  sharedPrivateLinkResourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceGroupName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceName: string,
): void;

@@override(
  SignalRSharedPrivateLinkResources.createOrUpdate,
  SignalRSharedPrivateLinkResourcesCreateOrUpdateCustomized,
  "java,go,python,javascript"
);
@@override(
  SignalRSharedPrivateLinkResources.get,
  SignalRSharedPrivateLinkResourcesGetCustomized,
  "java,go,python,javascript"
);
@@override(
  SignalRSharedPrivateLinkResources.delete,
  SignalRSharedPrivateLinkResourcesDeleteCustomized,
  "java,go,python,javascript"
);

// Resolve model naming breaking changes from Swagger directive migration
@@clientName(SignalRResource, "ResourceInfo", "go");
@@clientName(SignalRResourceList, "ResourceInfoList", "go");

@@clientName(SignalRResource, "SignalR", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "RBAC roles for provisioning"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "RBAC roles for provisioning"
@@clientOption(
  SignalRResource,
  "resource-rbac-roles",
  #{
    SignalRAccessKeyReader: "04165923-9d83-45d5-8227-78b77b0a687e",
    SignalRAppServer: "420fcaa2-552c-430f-98ca-3264be4806c7",
    SignalRRestApiOwner: "fd53cd77-2268-407a-8f46-7e7863d0f521",
    SignalRRestApiReader: "ddde6b66-c0df-4114-a159-3618637b3035",
    SignalRServiceOwner: "7e4f1700-ea5a-4f59-8f37-079cfe29dce3",
    SignalRContributor: "8cf5e20a-e4b2-4e9d-b3a1-5ceb692c2761",
  },
  "csharp"
);
@@clientName(CustomCertificate, "SignalRCustomCertificate", "csharp");
@@clientName(CustomDomain, "SignalRCustomDomain", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "SignalRPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  SharedPrivateLinkResource,
  "SignalRSharedPrivateLinkResource",
  "csharp"
);
@@clientName(ProvisioningState, "SignalRProvisioningState", "csharp");
@@clientName(FeatureFlags, "SignalRFeatureFlag", "csharp");
@@clientName(KeyType, "SignalRKeyType", "csharp");
@@clientName(LiveTraceCategory, "SignalRLiveTraceCategory", "csharp");
@@clientName(LiveTraceConfiguration, "SignalRLiveTraceConfiguration", "csharp");
@@clientName(ResourceLogCategory, "SignalRResourceLogCategory", "csharp");
@@clientName(ResourceSku, "SignalRResourceSku", "csharp");
@@clientName(ScaleType, "SignalRScaleType", "csharp");
@@clientName(ServiceKind, "SignalRServiceKind", "csharp");
@@clientName(
  SharedPrivateLinkResourceStatus,
  "SignalRSharedPrivateLinkResourceStatus",
  "csharp"
);
@@clientName(SkuCapacity, "SignalRSkuCapacity", "csharp");
@@clientName(UpstreamAuthSettings, "SignalRUpstreamAuthSettings", "csharp");
@@clientName(UpstreamAuthSettings.type, "AuthType", "csharp");
@@clientName(UpstreamAuthType, "SignalRUpstreamAuthType", "csharp");
@@clientName(UpstreamTemplate, "SignalRUpstreamTemplate", "csharp");
@@clientName(
  SignalRTlsSettings.clientCertEnabled,
  "IsClientCertEnabled",
  "csharp"
);
@@clientName(
  SignalROperationGroup.checkNameAvailability,
  "CheckSignalRNameAvailability",
  "csharp"
);
@@clientName(
  SignalROperationGroup.checkNameAvailability::parameters.body,
  "content",
  "csharp"
);
@@alternateType(
  SignalROperationGroup.checkNameAvailability::parameters.location,
  azureLocation,
  "csharp"
);
@@clientName(NetworkACL, "SignalRNetworkAcl", "csharp");
@@clientName(CustomCertificateList, "SignalRCustomCertificateList", "csharp");
@@clientName(CustomDomainList, "SignalRCustomDomainList", "csharp");
@@clientName(NameAvailability, "SignalRNameAvailabilityResult", "csharp");
@@clientName(
  NameAvailabilityParameters,
  "SignalRNameAvailabilityContent",
  "csharp"
);
@@clientName(NameAvailabilityParameters.type, "resourceType", "csharp");
@@alternateType(NameAvailabilityParameters.type, armResourceType, "csharp");
@@clientName(ACLAction, "SignalRNetworkAclAction", "csharp");
@@clientName(PrivateEndpointACL, "SignalRPrivateEndpointAcl", "csharp");
@@clientName(
  PrivateEndpointConnectionList,
  "SignalRPrivateEndpointConnectionListResult",
  "csharp"
);
@@clientName(
  PrivateLinkResourceList,
  "SignalRPrivateLinkResourceListResult",
  "csharp"
);
@@clientName(
  ResourceLogConfiguration,
  "SignalRResourceLogConfiguration",
  "csharp"
);
@@clientName(
  SharedPrivateLinkResourceList,
  "SignalRSharedPrivateLinkResourceListResult",
  "csharp"
);
@@clientName(SkuList, "SignalRSkuListResult", "csharp");
@@clientName(NameAvailability.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(SignalRRequestType.RESTAPI, "RestApi", "csharp");
@@alternateType(Sku.resourceType, armResourceType, "csharp");
@@alternateType(CustomCertificateProperties.keyVaultBaseUri, url, "csharp");
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(
  UsagesOperationGroup.list::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(
  SharedPrivateLinkResourceProperties.privateLinkResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(
  ShareablePrivateLinkResourceProperties.type,
  "ShareablePrivateLinkResourcePropertiesType",
  "csharp"
);
@@alternateType(SignalRUsage.id, armResourceIdentifier, "csharp");
@@clientName(SignalRNetworkACLs, "SignalRNetworkAcls", "csharp");
@@clientName(PrivateLinkResource, "SignalRPrivateLinkResource", "csharp");
@@clientName(SignalRResources.list, "GetSignalRPrivateLinkResources", "csharp");
@@clientName(RegenerateKeyParameters, "SignalRRegenerateKeyContent", "csharp");
@@usage(
  ShareablePrivateLinkResourceProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(ShareablePrivateLinkResourceType, Usage.input | Usage.output, "csharp");
@@clientName(Replica, "SignalRReplica", "csharp");
@@clientName(
  SharedPrivateLinkResources,
  "SignalRReplicaSharedPrivateLinkResources",
  "csharp"
);
@@alternateType(ResourceReference.id, armResourceIdentifier, "csharp");
@@alternateType(
  SignalRResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@clientName(
  ApplicationFirewallSettings,
  "SignalRApplicationFirewallSettings",
  "csharp"
);
@@clientName(
  ClientConnectionCountRule,
  "SignalRClientConnectionCountRule",
  "csharp"
);
@@clientName(IPRule, "SignalRIPRule", "csharp");
@@clientName(RouteSettings, "SignalRRouteSettings", "csharp");
@@clientName(ServerlessSettings, "SignalRServerlessSettings", "csharp");
@@clientName(UsagesOperationGroup.list, "GetUsages", "csharp");
@@clientName(
  SignalRResources.regenerateKey::parameters.body,
  "content",
  "csharp"
);
@@clientName(
  ClientTrafficControlRule,
  "SignalRClientTrafficControlRule",
  "csharp"
);
@@clientName(
  ThrottleByJwtCustomClaimRule,
  "SignalRThrottleByJwtCustomClaimRule",
  "csharp"
);
@@clientName(
  ThrottleByJwtSignatureRule,
  "SignalRThrottleByJwtSignatureRule",
  "csharp"
);
@@clientName(ThrottleByUserIdRule, "SignalRThrottleByUserIdRule", "csharp");
@@clientName(
  TrafficThrottleByJwtCustomClaimRule,
  "SignalRTrafficThrottleByJwtCustomClaimRule",
  "csharp"
);
@@clientName(
  TrafficThrottleByJwtSignatureRule,
  "SignalRTrafficThrottleByJwtSignatureRule",
  "csharp"
);
@@clientName(
  TrafficThrottleByUserIdRule,
  "SignalRTrafficThrottleByUserIdRule",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@markAsPageable(Replicas.listReplicaSkus, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@markAsPageable(SignalRResources.listSkus, "csharp");
