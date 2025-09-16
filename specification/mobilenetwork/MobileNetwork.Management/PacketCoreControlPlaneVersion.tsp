import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Packet core control plane version resource.
 */
@tenantResource
model PacketCoreControlPlaneVersion
  is Azure.ResourceManager.ProxyResource<
    PacketCoreControlPlaneVersionPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = PacketCoreControlPlaneVersion,
    KeyName = "versionName",
    SegmentName = "packetCoreControlPlaneVersions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PacketCoreControlPlaneVersionOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.MobileNetwork",
      },
      {},
      {
        /** The name of the packet core control plane version. */
        @path
        @segment("packetCoreControlPlaneVersions")
        @key
        versionName: string,
      }
    > {}

@armResourceOperations
interface PacketCoreControlPlaneVersions {
  /**
   * Gets information about the specified packet core control plane version.
   */
  get is PacketCoreControlPlaneVersionOps.Read<PacketCoreControlPlaneVersion>;

  /**
   * Lists all supported packet core control planes versions.
   */
  list is PacketCoreControlPlaneVersionOps.List<PacketCoreControlPlaneVersion>;
}
@armResourceOperations
interface PacketCoreControlPlaneVersionOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.MobileNetwork",
      },
      {},
      {
        /** The name of the packet core control plane version. */
        @path
        @segment("packetCoreControlPlaneVersions")
        @key
        versionName: string,
      }
    > {}

@armResourceOperations
interface PacketCoreControlPlaneVersionOperationGroup {
  /**
   * Gets information about the specified packet core control plane version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PacketCoreControlPlaneVersions_GetBySubscription")
  getBySubscription is PacketCoreControlPlaneVersionOperationGroupOps.Read<PacketCoreControlPlaneVersion>;

  /**
   * Lists all supported packet core control planes versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PacketCoreControlPlaneVersions_ListBySubscription")
  listBySubscription is PacketCoreControlPlaneVersionOperationGroupOps.List<PacketCoreControlPlaneVersion>;
}

@@doc(PacketCoreControlPlaneVersion.name,
  "The name of the packet core control plane version."
);
@@doc(PacketCoreControlPlaneVersion.properties,
  "Packet core control plane version properties."
);
