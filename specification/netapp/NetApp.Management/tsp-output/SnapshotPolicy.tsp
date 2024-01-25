import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Snapshot policy information
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NetAppAccount)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotPolicyProperties)
model SnapshotPolicy extends TrackedResourceBase {
  /**
   * The name of the snapshot policy
   */
  @path
  @key("snapshotPolicyName")
  @segment("snapshotPolicies")
  @visibility("read")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Snapshot policy Properties
   */
  @extension("x-ms-client-flatten", true)
  properties: SnapshotPolicyProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SnapshotPolicy,
    SnapshotPolicyPatch,
    BaseParameters<SnapshotPolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Delete snapshot policy
   */
  delete is ArmResourceDeleteAsync<
    SnapshotPolicy,
    BaseParameters<SnapshotPolicy>,
    ArmLroLocationHeader
  >;

  /**
   * List snapshot policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SnapshotPolicies_List")
  list is ArmResourceListByParent<SnapshotPolicy>;

  /**
   * Get volumes associated with snapshot policy
   */
  // FIXME: SnapshotPolicies_ListVolumes could not be converted to a resource operation
  @summary("Get volumes for snapshot policy")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/snapshotPolicies/{snapshotPolicyName}/volumes")
  @get
  listVolumes is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the NetApp account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      /**
       * The name of the snapshot policy
       */
      @path
      snapshotPolicyName: string;
    },
    SnapshotPolicyVolumeList
  >;
}

@@projectedName(SnapshotPolicies.create::parameters.resource, "json", "body");
@@extension(SnapshotPolicies.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SnapshotPolicies.create::parameters.resource,
  "Snapshot policy object supplied in the body of the operation."
);
@@projectedName(SnapshotPolicies.update::parameters.properties, "json", "body");
@@extension(SnapshotPolicies.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SnapshotPolicies.update::parameters.properties,
  "Snapshot policy object supplied in the body of the operation."
);
