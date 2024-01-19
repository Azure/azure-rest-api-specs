import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("Packet core control plane resource.")
model PacketCoreControlPlane
  is TrackedResource<PacketCoreControlPlanePropertiesFormat> {
  @doc("The name of the packet core control plane.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCoreControlPlaneName")
  @segment("packetCoreControlPlanes")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface PacketCoreControlPlanes {
  @doc("Gets information about the specified packet core control plane.")
  get is ArmResourceRead<PacketCoreControlPlane>;

  @doc("Creates or updates a packet core control plane.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PacketCoreControlPlane,
    BaseParameters<PacketCoreControlPlane>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch packet core control plane resource.")
  updateTags is ArmCustomPatchSync<
    PacketCoreControlPlane,
    IdentityAndTagsObject
  >;

  @doc("Deletes the specified packet core control plane.")
  delete is ArmResourceDeleteAsync<
    PacketCoreControlPlane,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the packet core control planes in a resource group.")
  listByResourceGroup is ArmResourceListByParent<PacketCoreControlPlane>;

  @doc("Lists all the packet core control planes in a subscription.")
  listBySubscription is ArmListBySubscription<PacketCoreControlPlane>;

  @doc("Roll back the specified packet core control plane to the previous version, \"rollbackVersion\". Multiple consecutive rollbacks are not possible. This action may cause a service outage.")
  rollback is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  @doc("Reinstall the specified packet core control plane. This action will remove any transaction state from the packet core to return it to a known state. This action will cause a service outage.")
  reinstall is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  @doc("Collect a diagnostics package for the specified packet core control plane. This action will upload the diagnostics to a storage account.")
  collectDiagnosticsPackage is ArmResourceActionAsync<
    PacketCoreControlPlane,
    PacketCoreControlPlaneCollectDiagnosticsPackage,
    AsyncOperationStatus,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;
}

@@projectedName(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet core control plane operation."
);
@@projectedName(PacketCoreControlPlanes.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(PacketCoreControlPlanes.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(PacketCoreControlPlanes.updateTags::parameters.properties,
  "Parameters supplied to patch packet core control plane resource."
);
@@projectedName(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "json",
  "parameters"
);
@@extension(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "Parameters supplied to the packet core control plane collect diagnostics package operation."
);
