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

namespace Microsoft.DataProtection;
@doc("Backup Vault Resource")
model BackupVaultResource is TrackedResource<BackupVault> {
  @doc("The name of the backup vault.")
  @path
  @key("vaultName")
  @segment("backupVaults")
  name: string;
}

@armResourceOperations
interface BackupVaultResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a resource belonging to a resource group.")
  @operationId("BackupVaults_Get")
  get is ArmResourceRead<BackupVaultResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a BackupVault resource belonging to a resource group.")
  @operationId("BackupVaults_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BackupVaultResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.")
  @operationId("BackupVaults_Update")
  update is ArmCustomPatchAsync<BackupVaultResource, PatchResourceRequestInput>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a BackupVault resource from the resource group.")
  @operationId("BackupVaults_Delete")
  delete is ArmResourceDeleteAsync<BackupVaultResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns resource collection belonging to a resource group.")
  @operationId("BackupVaults_GetInResourceGroup")
  getInResourceGroup is ArmResourceListByParent<BackupVaultResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns resource collection belonging to a subscription.")
  @operationId("BackupVaults_GetInSubscription")
  getInSubscription is ArmListBySubscription<BackupVaultResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Validate whether adhoc backup will be successful or not")
  @operationId("BackupInstances_ValidateForBackup")
  validateForBackup is ArmResourceActionAsync<
    BackupVaultResource,
    ValidateForBackupRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupVaultResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Triggers export of jobs and returns an OperationID to track.")
  @operationId("ExportJobs_Trigger")
  trigger is ArmResourceActionNoResponseContentAsync<
    BackupVaultResource,
    void,
    BaseParameters<BackupVaultResource>,
    ArmLroLocationHeader
  >;
}

@@projectedName(BackupVaultResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@projectedName(BackupVaultResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.update::parameters.properties,
  "Request body for operation"
);
@@projectedName(BackupVaultResources.validateForBackup::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.validateForBackup::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.validateForBackup::parameters.body,
  "Request body for operation"
);
