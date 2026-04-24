import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Rack_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the rack.
 */
model RackNameParameter
  is ResourceNameParameter<
    Resource = Rack,
    KeyName = "rackName",
    SegmentName = "racks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * Rack represents the hardware of the rack and is dependent upon the cluster for lifecycle.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model Rack is Azure.ResourceManager.TrackedResource<RackProperties, false> {
  ...RackNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface Racks {
  /**
   * Get properties of the provided rack.
   */
  get is ArmResourceRead<Rack>;

  /**
   * Create a new rack or update properties of the existing one. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Rack,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Rack>
  >;

  /**
   * Patch properties of the provided rack, or update the tags associated with the rack. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Rack,
    PatchModel = RackPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Rack> &
      ArmLroLocationHeader<FinalResult = Rack>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided rack. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Rack,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of racks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Rack,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<RackList>
  >;

  /**
   * Get a list of racks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    Rack,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<RackList>
  >;
}

@@doc(Rack.name, "The name of the rack.");
@@doc(Rack.properties, "The list of the resource properties.");
@@doc(Racks.createOrUpdate::parameters.resource, "The request body.");
@@doc(Racks.update::parameters.properties, "The request body.");
