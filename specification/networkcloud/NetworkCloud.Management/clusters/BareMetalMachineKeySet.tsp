import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./BareMetalMachineKeySet_models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the bare metal machine key set.
 */
model BareMetalMachineKeySetNameParameter
  is ResourceNameParameter<
    Resource = BareMetalMachineKeySet,
    KeyName = "bareMetalMachineKeySetName",
    SegmentName = "bareMetalMachineKeySets",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * BareMetalMachineKeySet represents the bare metal machine key set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(Cluster)
model BareMetalMachineKeySet
  is Azure.ResourceManager.TrackedResource<
    BareMetalMachineKeySetProperties,
    false
  > {
  ...BareMetalMachineKeySetNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface BareMetalMachineKeySets {
  /**
   * Get bare metal machine key set of the provided cluster.
   */
  get is ArmResourceRead<BareMetalMachineKeySet>;

  /**
   * Create a new bare metal machine key set or update the existing one for the provided cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachineKeySet,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachineKeySet>
  >;

  /**
   * Patch properties of bare metal machine key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachineKeySet,
    PatchModel = BareMetalMachineKeySetPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachineKeySet> &
      ArmLroLocationHeader<FinalResult = BareMetalMachineKeySet>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the bare metal machine key set of the provided cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachineKeySet,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of bare metal machine key sets for the provided cluster.
   */
  listByCluster is ArmResourceListByParent<
    BareMetalMachineKeySet,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<BareMetalMachineKeySetList>
  >;
}

@@doc(BareMetalMachineKeySet.name,
  "The name of the bare metal machine key set."
);
@@doc(BareMetalMachineKeySet.properties,
  "The list of the resource properties."
);
@@doc(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(BareMetalMachineKeySets.update::parameters.properties,
  "The request body."
);
