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
/**
 * AzureBackup Job Resource Class
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BackupVaultResource)
@Azure.ResourceManager.Private.armResourceInternal(AzureBackupJob)
@includeInapplicableMetadataInPayload(false)
model AzureBackupJobResource extends ProxyResourceBase {
  /**
   * The Job ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
   */
  @path
  @key("jobId")
  @segment("backupJobs")
  name: string;

  /**
   * AzureBackupJobResource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureBackupJob;
}

@armResourceOperations
interface AzureBackupJobResources {
  /**
   * Gets a job with id in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_Get")
  get is ArmResourceRead<AzureBackupJobResource>;

  /**
   * Returns list of jobs belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_List")
  list is ArmResourceListByParent<AzureBackupJobResource>;
}
