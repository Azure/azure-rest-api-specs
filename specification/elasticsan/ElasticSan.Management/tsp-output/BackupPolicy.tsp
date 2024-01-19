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
@doc("Backup policy information")
@parentResource(NetAppAccount)
model BackupPolicy is TrackedResource<BackupPolicyProperties> {
  @doc("Backup policy Name which uniquely identify backup policy.")
  @path
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
  create is ArmResourceCreateOrUpdateAsync<
    BackupPolicy,
    BaseParameters<BackupPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch a backup policy for Netapp Account")
  update is ArmCustomPatchAsync<
    BackupPolicy,
    BackupPolicyPatch,
    BaseParameters<BackupPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete backup policy")
  delete is ArmResourceDeleteAsync<
    BackupPolicy,
    BaseParameters<BackupPolicy>,
    ArmLroLocationHeader
  >;

  @doc("List backup policies for Netapp Account")
  list is ArmResourceListByParent<BackupPolicy>;
}

@@projectedName(BackupPolicies.create::parameters.resource, "json", "body");
@@extension(BackupPolicies.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(BackupPolicies.create::parameters.resource,
  "Backup policy object supplied in the body of the operation."
);
@@projectedName(BackupPolicies.update::parameters.properties, "json", "body");
@@extension(BackupPolicies.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(BackupPolicies.update::parameters.properties,
  "Backup policy object supplied in the body of the operation."
);
