import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./BmcKeySet_models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the baseboard management controller key set.
 */
model BmcKeySetNameParameter
  is ResourceNameParameter<
    Resource = BmcKeySet,
    KeyName = "bmcKeySetName",
    SegmentName = "bmcKeySets",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * BmcKeySet represents the baseboard management controller key set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(Cluster)
model BmcKeySet
  is Azure.ResourceManager.TrackedResource<BmcKeySetProperties, false> {
  ...BmcKeySetNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface BmcKeySets {
  /**
   * Get baseboard management controller key set of the provided cluster.
   */
  get is ArmResourceRead<BmcKeySet>;

  /**
   * Create a new baseboard management controller key set or update the existing one for the provided cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BmcKeySet,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BmcKeySet>
  >;

  /**
   * Patch properties of baseboard management controller key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BmcKeySet,
    PatchModel = BmcKeySetPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BmcKeySet> &
      ArmLroLocationHeader<FinalResult = BmcKeySet>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the baseboard management controller key set of the provided cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BmcKeySet,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of baseboard management controller key sets for the provided cluster.
   */
  listByCluster is ArmResourceListByParent<
    BmcKeySet,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<BmcKeySetList>
  >;
}

@@doc(BmcKeySet.name,
  "The name of the baseboard management controller key set."
);
@@doc(BmcKeySet.properties, "The list of the resource properties.");
@@doc(BmcKeySets.createOrUpdate::parameters.resource, "The request body.");
@@doc(BmcKeySets.update::parameters.properties, "The request body.");
