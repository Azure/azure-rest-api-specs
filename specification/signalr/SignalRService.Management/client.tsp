import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(
  Microsoft.SignalRService.Versions.v2025_01_01_preview
)
namespace Customization;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRPrivateEndpointConnectionsDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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

@@override(PrivateEndpointConnections.get,
  SignalRPrivateEndpointConnectionsGetCustomized,
  "python,java,go"
);
@@override(PrivateEndpointConnections.update,
  SignalRPrivateEndpointConnectionsUpdateCustomized,
  "python,java,go"
);
@@override(PrivateEndpointConnections.delete,
  SignalRPrivateEndpointConnectionsDeleteCustomized,
  "python,java,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SignalRSharedPrivateLinkResourcesDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

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

@@override(SignalRSharedPrivateLinkResources.createOrUpdate,
  SignalRSharedPrivateLinkResourcesCreateOrUpdateCustomized,
  "python,java,go"
);
@@override(SignalRSharedPrivateLinkResources.get,
  SignalRSharedPrivateLinkResourcesGetCustomized,
  "python,java,go"
);
@@override(SignalRSharedPrivateLinkResources.delete,
  SignalRSharedPrivateLinkResourcesDeleteCustomized,
  "python,java,go"
);
