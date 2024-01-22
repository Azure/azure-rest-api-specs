import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupInstanceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Azure backup recoveryPoint resource
 */
@parentResource(BackupInstanceResource)
model AzureBackupRecoveryPointResource
  is ProxyResource<AzureBackupRecoveryPoint> {
  @path
  @key("recoveryPointId")
  @segment("recoveryPoints")
  name: string;
}

@armResourceOperations
interface AzureBackupRecoveryPointResources {
  /**
   * Gets a Recovery Point using recoveryPointId for a Datasource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoveryPoints_Get")
  get is ArmResourceRead<AzureBackupRecoveryPointResource>;

  /**
   * Returns a list of Recovery Points for a DataSource in a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoveryPoints_List")
  list is ArmResourceListByParent<
    AzureBackupRecoveryPointResource,
    {
      ...BaseParameters<AzureBackupRecoveryPointResource>;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
