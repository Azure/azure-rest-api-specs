import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "./BackupInstanceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Azure backup recoveryPoint resource
 */
@parentResource(BackupInstanceResource)
model AzureBackupRecoveryPointResource
  is Azure.ResourceManager.ProxyResource<AzureBackupRecoveryPoint> {
  ...ResourceNameParameter<
    Resource = AzureBackupRecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AzureBackupRecoveryPointResources {
  /**
   * Gets a Recovery Point using recoveryPointId for a Datasource.
   */
  get is ArmResourceRead<
    Resource = AzureBackupRecoveryPointResource,
    Error = CloudError
  >;

  /**
   * Returns a list of Recovery Points for a DataSource in a vault.
   */
  @list
  list is ArmResourceListByParent<
    AzureBackupRecoveryPointResource,
    Parameters = {
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
    },
    Response = ArmResponse<AzureBackupRecoveryPointResourceList>,
    Error = CloudError
  >;
}

@@doc(AzureBackupRecoveryPointResource.name, "");
@@doc(AzureBackupRecoveryPointResource.properties,
  "AzureBackupRecoveryPointResource properties"
);
