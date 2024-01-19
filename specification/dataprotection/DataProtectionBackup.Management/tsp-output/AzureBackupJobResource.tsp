import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
@doc("AzureBackup Job Resource Class")
@parentResource(BackupVaultResource)
model AzureBackupJobResource is ProxyResource<AzureBackupJob> {
  @doc("The Job ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
  @path
  @key("jobId")
  @segment("backupJobs")
  name: string;
}

@armResourceOperations
interface AzureBackupJobResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a job with id in a backup vault")
  @operationId("Jobs_Get")
  get is ArmResourceRead<AzureBackupJobResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns list of jobs belonging to a backup vault")
  @operationId("Jobs_List")
  list is ArmResourceListByParent<AzureBackupJobResource>;
}
