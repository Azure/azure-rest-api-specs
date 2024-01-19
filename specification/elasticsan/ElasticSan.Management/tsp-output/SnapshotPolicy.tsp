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
@doc("Snapshot policy information")
@parentResource(NetAppAccount)
model SnapshotPolicy is TrackedResource<SnapshotPolicyProperties> {
  @doc("The name of the snapshot policy")
  @path
  @key("snapshotPolicyName")
  @segment("snapshotPolicies")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface SnapshotPolicies {
  @doc("Get a snapshot Policy")
  get is ArmResourceRead<SnapshotPolicy>;

  @doc("Create a snapshot policy")
  create is ArmResourceCreateOrReplaceSync<SnapshotPolicy>;

  @doc("Patch a snapshot policy")
  update is ArmCustomPatchAsync<
    SnapshotPolicy,
    SnapshotPolicyPatch,
    BaseParameters<SnapshotPolicy>,
    ArmLroLocationHeader
  >;

  @doc("Delete snapshot policy")
  delete is ArmResourceDeleteAsync<
    SnapshotPolicy,
    BaseParameters<SnapshotPolicy>,
    ArmLroLocationHeader
  >;

  @doc("List snapshot policy")
  list is ArmResourceListByParent<SnapshotPolicy>;

  @summary("Get volumes for snapshot policy")
  @doc("Get volumes associated with snapshot policy")
  // FIXME: SnapshotPolicies_ListVolumes could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/snapshotPolicies/{snapshotPolicyName}/volumes")
  @get
  listVolumes is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the NetApp account")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      @doc("The name of the snapshot policy")
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
