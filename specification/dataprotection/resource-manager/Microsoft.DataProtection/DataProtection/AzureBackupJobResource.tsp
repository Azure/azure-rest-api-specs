import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DataProtection;
/**
 * AzureBackup Job Resource Class
 */
@parentResource(BackupVaultResource)
model AzureBackupJobResource
  is Azure.ResourceManager.ProxyResource<AzureBackupJob> {
  ...ResourceNameParameter<
    Resource = AzureBackupJobResource,
    KeyName = "jobId",
    SegmentName = "backupJobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AzureBackupJobResources {
  /**
   * Gets a job with id in a backup vault
   */
  get is ArmResourceRead<Resource = AzureBackupJobResource, Error = CloudError>;

  /**
   * Returns list of jobs belonging to a backup vault
   */
  @list
  list is ArmResourceListByParent<
    AzureBackupJobResource,
    Response = ArmResponse<AzureBackupJobResourceList>,
    Error = CloudError
  >;
}

@@doc(AzureBackupJobResource.name,
  "The Job ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(AzureBackupJobResource.properties, "AzureBackupJobResource properties");
