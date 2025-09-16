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
 * Packet core control plane resource.
 */
model PacketCoreControlPlane
  is Azure.ResourceManager.TrackedResource<
    PacketCoreControlPlanePropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = PacketCoreControlPlane,
    KeyName = "packetCoreControlPlaneName",
    SegmentName = "packetCoreControlPlanes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;

  /**
   * The identity used to retrieve the ingress certificate from Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCoreControlPlane>;

  /**
   * Patch packet core control plane resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    PacketCoreControlPlane,
    PatchModel = IdentityAndTagsObject
  >;

  /**
   * Deletes the specified packet core control plane.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PacketCoreControlPlane,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the packet core control planes in a resource group.
   */
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
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * Reinstall the specified packet core control plane. This action will try to restore the packet core to the installed state that was disrupted by a transient failure. This action will cause a service outage.
   */
  reinstall is ArmResourceActionAsync<
    PacketCoreControlPlane,
    void,
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * Collect a diagnostics package for the specified packet core control plane. This action will upload the diagnostics to a storage account.
   */
  collectDiagnosticsPackage is ArmResourceActionAsync<
    PacketCoreControlPlane,
    PacketCoreControlPlaneCollectDiagnosticsPackage,
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * List all UEs and their state in a packet core.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UeInformation_List")
  @list
  @get
  @action("ues")
  list is ArmResourceActionSync<
    PacketCoreControlPlane,
    void,
    ArmResponse<UeInfoList>
  >;
}

@@maxLength(PacketCoreControlPlane.name, 64);
@@doc(PacketCoreControlPlane.name,
  "The name of the packet core control plane."
);
@@doc(PacketCoreControlPlane.properties,
  "Packet core control plane Properties."
);
@@doc(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet core control plane operation."
);
@@doc(PacketCoreControlPlanes.updateTags::parameters.properties,
  "Parameters supplied to patch packet core control plane resource."
);
@@doc(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "Parameters supplied to the packet core control plane collect diagnostics package operation."
);
