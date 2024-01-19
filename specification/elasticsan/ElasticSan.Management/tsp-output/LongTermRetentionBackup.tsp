import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A long term retention backup.")
@locationResource
model LongTermRetentionBackup
  is ProxyResource<LongTermRetentionBackupProperties> {
  @doc("The backup name.")
  @path
  @key("backupName")
  @segment("longTermRetentionBackups")
  name: string;
}

@armResourceOperations
interface LongTermRetentionBackups {
  @doc("Gets a long term retention backup.")
  get is ArmResourceRead<LongTermRetentionBackup>;

  @doc("Deletes a long term retention backup.")
  delete is ArmResourceDeleteAsync<LongTermRetentionBackup>;

  @doc("Lists all long term retention backups for a database.")
  listByDatabase is ArmResourceListByParent<
    LongTermRetentionBackup,
    {
      ...BaseParameters<LongTermRetentionBackup>;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;

  @doc("Copy an existing long term retention backup.")
  copy is ArmResourceActionAsync<
    LongTermRetentionBackup,
    CopyLongTermRetentionBackupParameters,
    LongTermRetentionBackupOperationResult
  >;

  @doc("Updates an existing long term retention backup.")
  update is ArmResourceActionAsync<
    LongTermRetentionBackup,
    UpdateLongTermRetentionBackupParameters,
    LongTermRetentionBackupOperationResult
  >;
}

@@projectedName(LongTermRetentionBackups.copy::parameters.body,
  "json",
  "parameters"
);
@@extension(LongTermRetentionBackups.copy::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(LongTermRetentionBackups.copy::parameters.body,
  "The parameters needed for long term retention copy request"
);
@@projectedName(LongTermRetentionBackups.update::parameters.body,
  "json",
  "parameters"
);
@@extension(LongTermRetentionBackups.update::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(LongTermRetentionBackups.update::parameters.body,
  "The requested backup resource state"
);
