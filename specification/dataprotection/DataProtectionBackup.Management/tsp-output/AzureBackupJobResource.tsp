import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataProtection;
@doc("AzureBackup Job Resource Class")
@parentResource(BackupVaultResource)
model AzureBackupJobResource is ProxyResource<AzureBackupJob> {
  @doc("The Job ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
  @key("jobId")
  @segment("backupJobs")
  name: string;
}

@armResourceOperations
@projectedName("client", "Jobs")
interface AzureBackupJobResources_Jobs {
  @doc("Gets a job with id in a backup vault")
  get is ArmResourceRead<AzureBackupJobResource>;

  @doc("Returns list of jobs belonging to a backup vault")
  list is ArmResourceListByParent<AzureBackupJobResource>;
}
