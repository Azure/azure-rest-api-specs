import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NetApp;
@doc("Backup policy information")
@parentResource(NetAppAccount)
model BackupPolicy is TrackedResource<BackupPolicyProperties> {
  @doc("Backup policy Name which uniquely identify backup policy.")
  @key("backupPolicyName")
  @segment("backupPolicies")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface BackupPolicies {
  @doc("Get a particular backup Policy")
  get is ArmResourceRead<BackupPolicy>;

  @doc("Create a backup policy for Netapp Account")
  create is ArmResourceCreateOrUpdateAsync<BackupPolicy>;

  @doc("Patch a backup policy for Netapp Account")
  update is ArmCustomPatchAsync<BackupPolicy, BackupPolicyPatch>;

  @doc("Delete backup policy")
  delete is ArmResourceDeleteAsync<BackupPolicy>;

  @doc("List backup policies for Netapp Account")
  list is ArmResourceListByParent<BackupPolicy>;
}
