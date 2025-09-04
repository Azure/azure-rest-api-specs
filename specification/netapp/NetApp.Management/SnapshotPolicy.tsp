import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Snapshot policy information
 */
@parentResource(NetAppAccount)
model SnapshotPolicy
  is Azure.ResourceManager.TrackedResource<SnapshotPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = SnapshotPolicy,
    KeyName = "snapshotPolicyName",
    SegmentName = "snapshotPolicies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface SnapshotPolicies {
  /**
   * Get a snapshot Policy
   */
  get is ArmResourceRead<SnapshotPolicy>;

  /**
   * Create a snapshot policy
   */
  create is ArmResourceCreateOrReplaceSync<SnapshotPolicy>;

  /**
   * Patch a snapshot policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SnapshotPolicy,
    PatchModel = SnapshotPolicyPatch,
    Response = ArmResponse<SnapshotPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SnapshotPolicy> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: SnapshotPolicy;
    })
  >;

  /**
   * Delete snapshot policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SnapshotPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List snapshot policy
   */
  list is ArmResourceListByParent<
    SnapshotPolicy,
    Response = ArmResponse<SnapshotPoliciesList>
  >;

  /**
   * Get volumes associated with snapshot policy
   */
  @get
  @action("volumes")
  listVolumes is ArmResourceActionSync<
    SnapshotPolicy,
    void,
    ArmResponse<SnapshotPolicyVolumeList>
  >;
}

@@doc(SnapshotPolicy.name, "The name of the snapshot policy");
@@doc(SnapshotPolicy.properties, "Snapshot policy Properties");
@@doc(SnapshotPolicies.create::parameters.resource,
  "Snapshot policy object supplied in the body of the operation."
);
@@doc(SnapshotPolicies.update::parameters.properties,
  "Snapshot policy object supplied in the body of the operation."
);
