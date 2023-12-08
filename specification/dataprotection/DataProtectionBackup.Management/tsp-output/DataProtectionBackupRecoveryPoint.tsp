import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataProtectionBackupInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("Azure backup recoveryPoint resource")
@parentResource(DataProtectionBackupInstance)
model DataProtectionBackupRecoveryPoint
  is ProxyResource<AzureBackupRecoveryPoint> {
  @path
  @key("recoveryPointId")
  @segment("recoveryPoints")
  name: string;
}

@armResourceOperations
interface DataProtectionBackupRecoveryPoints {
  @doc("Gets a Recovery Point using recoveryPointId for a Datasource.")
  get is ArmResourceRead<DataProtectionBackupRecoveryPoint>;
  @doc("Returns a list of Recovery Points for a DataSource in a vault.")
  list is ArmResourceListByParent<
    DataProtectionBackupRecoveryPoint,
    {
      ...BaseParameters<DataProtectionBackupRecoveryPoint>;

      @doc("OData filter options.")
      @query("$filter")
      $filter?: string;

      @doc("skipToken Filter.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
