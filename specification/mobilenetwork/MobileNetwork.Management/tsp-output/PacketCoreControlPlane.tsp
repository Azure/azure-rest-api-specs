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
/**
 * Packet core control plane resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  PacketCoreControlPlanePropertiesFormat
)
@includeInapplicableMetadataInPayload(false)
model PacketCoreControlPlane extends TrackedResourceBase {
  /**
   * The name of the packet core control plane.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCoreControlPlaneName")
  @segment("packetCoreControlPlanes")
  name: string;

  /**
   * Packet core control plane Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: PacketCoreControlPlanePropertiesFormat;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface PacketCoreControlPlanes {
  /**
   * Gets information about the specified packet core control plane.
   */
  get is ArmResourceRead<PacketCoreControlPlane>;

  /**
   * Creates or updates a packet core control plane.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PacketCoreControlPlane,
    BaseParameters<PacketCoreControlPlane>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch packet core control plane resource.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<
    PacketCoreControlPlane,
    IdentityAndTagsObject
  >;

  /**
   * Deletes the specified packet core control plane.
   */
  delete is ArmResourceDeleteAsync<
    PacketCoreControlPlane,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the packet core control planes in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PacketCoreControlPlanes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<PacketCoreControlPlane>;

  /**
   * Lists all the packet core control planes in a subscription.
   */
  listBySubscription is ArmListBySubscription<PacketCoreControlPlane>;

  /**
   * Roll back the specified packet core control plane to the previous version, "rollbackVersion". Multiple consecutive rollbacks are not possible. This action may cause a service outage.
   */
  rollback is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  /**
   * Reinstall the specified packet core control plane. This action will remove any transaction state from the packet core to return it to a known state. This action will cause a service outage.
   */
  reinstall is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    AsyncOperationStatus,
    BaseParameters<PacketCoreControlPlane>,
    ArmLroLocationHeader
  >;

  /**
   * Collect a diagnostics package for the specified packet core control plane. This action will upload the diagnostics to a storage account.
   */
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
