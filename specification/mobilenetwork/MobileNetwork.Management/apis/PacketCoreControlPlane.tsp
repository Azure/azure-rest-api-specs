import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/PacketCoreControlPlaneModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Packet core control plane resource.")
@resource("packetCoreControlPlanes")
model PacketCoreControlPlane
  is TrackedResource<PacketCoreControlPlanePropertiesFormat> {
  @doc("The name of the packet core control plane.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCoreControlPlaneName")
  @segment("packetCoreControlPlanes")
  @visibility("read")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @doc("The identity used to retrieve the ingress certificate from Azure key vault.")
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface PacketCoreControlPlanes {
  @doc("Gets information about the specified packet core control plane.")
  get is ArmResourceRead<PacketCoreControlPlane>;

  @doc("Creates or updates a packet core control plane.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCoreControlPlane>;

  @doc("Patch packet core control plane resource.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<
    PacketCoreControlPlane,
    IdentityAndTagsObject
  >;

  @doc("Deletes the specified packet core control plane.")
  delete is ArmResourceDeleteWithoutOkAsync<PacketCoreControlPlane>;

  @doc("Lists all the packet core control planes in a resource group.")
  listByResourceGroup is ArmResourceListByParent<PacketCoreControlPlane>;

  @doc("Lists all the packet core control planes in a subscription.")
  listBySubscription is ArmListBySubscription<PacketCoreControlPlane>;

  @doc("Roll back the specified packet core control plane to the previous version, \"rollbackVersion\". Multiple consecutive rollbacks are not possible. This action may cause a service outage.")
  rollback is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus
  >;

  @doc("Reinstall the specified packet core control plane. This action will try to restore the packet core to the installed state that was disrupted by a transient failure. This action will cause a service outage.")
  reinstall is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus
  >;

  @doc("Collect a diagnostics package for the specified packet core control plane. This action will upload the diagnostics to a storage account.")
  collectDiagnosticsPackage is ArmResourceActionAsync<
    PacketCoreControlPlane,
    PacketCoreControlPlaneCollectDiagnosticsPackage,
    AsyncOperationStatus
  >;
}

@@doc(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet core control plane operation."
);
@@doc(PacketCoreControlPlanes.updateTags::parameters.properties,
  "Parameters supplied to patch packet core control plane resource."
);
@@doc(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "Parameters supplied to the packet core control plane collect diagnostics package operation."
);
