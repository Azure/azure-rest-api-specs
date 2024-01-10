import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BackupInstanceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataProtection;
@doc("Azure backup recoveryPoint resource")
@parentResource(BackupInstanceResource)
model AzureBackupRecoveryPointResource
  is ProxyResource<AzureBackupRecoveryPoint> {
  @key("recoveryPointId")
  @segment("recoveryPoints")
  name: string;
}

@armResourceOperations
@projectedName("client", "RecoveryPoints")
interface AzureBackupRecoveryPointResources_RecoveryPoints {
  @doc("Gets a Recovery Point using recoveryPointId for a Datasource.")
  get is ArmResourceRead<AzureBackupRecoveryPointResource>;

  @doc("Returns a list of Recovery Points for a DataSource in a vault.")
  list is ArmResourceListByParent<
    AzureBackupRecoveryPointResource,
    {
      ...BaseParameters<AzureBackupRecoveryPointResource>;

      @doc("OData filter options.")
      @query("$filter")
      $filter?: string;

      @doc("skipToken Filter.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
