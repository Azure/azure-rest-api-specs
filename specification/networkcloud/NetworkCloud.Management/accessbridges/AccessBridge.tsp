import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./AccessBridge_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;
/**
 * The name of the access bridge.
 */
@added(Versions.v2026_01_01_preview)
model AccessBridgeNameParameter
  is ResourceNameParameter<
    Resource = AccessBridge,
    KeyName = "accessBridgeName",
    SegmentName = "accessBridges",
    NamePattern = "",
    Type = AccessBridgeAllowedName
  >;

/**
 * AccessBridge represents a managed access bridge resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@added(Versions.v2026_01_01_preview)
model AccessBridge
  is Azure.ResourceManager.TrackedResource<AccessBridgeProperties, false> {
  ...AccessBridgeNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface AccessBridges {
  /**
   * Get the properties of the provided access bridge.
   */
  get is ArmResourceRead<AccessBridge>;

  /**
   * Create a new access bridge or update the properties of the existing access bridge.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AccessBridge,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AccessBridge>
  >;

  /**
   * Update properties of the provided access bridge, or update tags associated with the access bridge. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    AccessBridge,
    PatchModel = AccessBridgePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AccessBridge> &
      ArmLroLocationHeader<FinalResult = AccessBridge>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the specified access bridge.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessBridge,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of access bridges in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AccessBridge,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<AccessBridgeList>
  >;

  /**
   * Get a list of access bridges in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    AccessBridge,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<AccessBridgeList>
  >;
}

@@doc(AccessBridge.name, "The name of the access bridge.");
@@doc(AccessBridge.properties, "The list of the resource properties.");
@@doc(AccessBridges.createOrUpdate::parameters.resource,
  "The access bridge configuration."
);
@@doc(AccessBridges.update::parameters.properties, "The request body.");
