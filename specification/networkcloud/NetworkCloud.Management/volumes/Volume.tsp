import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Volume_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the volume.
 */
model VolumeNameParameter
  is ResourceNameParameter<
    Resource = Volume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9])$"
  >;

/**
 * Volume represents storage made available for use by resources running on the cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model Volume is Azure.ResourceManager.TrackedResource<VolumeProperties, false> {
  ...VolumeNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface Volumes {
  /**
   * Get properties of the provided volume.
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create a new volume or update the properties of the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Volume>
  >;

  /**
   * Update tags associated with the provided volume.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    Volume,
    PatchModel = VolumePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided volume.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of volumes in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Volume,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<VolumeList>
  >;

  /**
   * Get a list of volumes in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    Volume,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<VolumeList>
  >;
}

@@doc(Volume.name, "The name of the volume.");
@@doc(Volume.properties, "The list of the resource properties.");
@@doc(Volumes.createOrUpdate::parameters.resource, "The request body.");
@@doc(Volumes.update::parameters.properties, "The request body.");
