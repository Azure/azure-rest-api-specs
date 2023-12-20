import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataProtectionBackupVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("AzureBackup Job Resource Class")
@parentResource(DataProtectionBackupVault)
model DataProtectionBackupJob is ProxyResource<AzureBackupJob> {
  @doc("The Job ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
  @path
  @key("jobId")
  @segment("backupJobs")
  name: string;
}

@armResourceOperations
interface DataProtectionBackupJobs {
  @doc("Gets a job with id in a backup vault")
  get is ArmResourceRead<DataProtectionBackupJob>;
  @doc("Returns list of jobs belonging to a backup vault")
  list is ArmResourceListByParent<DataProtectionBackupJob>;
}
