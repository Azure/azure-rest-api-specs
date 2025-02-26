import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace KeyVault;

/**
 * Returns the status of full backup operation
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@route("/backup/{jobId}/pending")
@get
op fullBackupStatus is KeyVaultOperation<
  {
    /**
     * The id returned as part of the backup request
     */
    @path
    jobId: string;
  },
  FullBackupOperation
>;

/**
 * Creates a full backup using a user-provided SAS token to an Azure blob storage container.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@pollingOperation(fullBackupStatus)
@finalOperation(fullBackupStatus)
@useFinalStateVia("azure-async-operation")
@route("/backup")
@post
op fullBackup is KeyVaultOperation<
  {
    /**
     * Azure blob shared access signature token pointing to a valid Azure blob container where full backup needs to be stored. This token needs to be valid for at least next 24 hours from the time of making this call.
     */
    @body azureStorageBlobContainerUri: SASTokenParameter;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The backup operation.
     */
    @body response: FullBackupOperation;
  }
>;

/**
 * Pre-backup operation for checking whether the customer can perform a full backup operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.`v7.6_preview.2`)
@pollingOperation(fullBackupStatus)
@finalOperation(fullBackupStatus)
@useFinalStateVia("azure-async-operation")
@route("/prebackup")
@post
op preFullBackup is KeyVaultOperation<
  {
    /** Optional parameters to validate prior to performing a full backup operation. */
    @body preBackupOperationParameters: PreBackupOperationParameters;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The backup operation.
     */
    @body response: FullBackupOperation;
  }
>;

/**
 * Returns the status of restore operation
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@sharedRoute
@route("/restore/{jobId}/pending")
@get
op restoreStatus is KeyVaultOperation<
  {
    /**
     * The Job Id returned part of the restore operation
     */
    @path
    jobId: string;
  },
  RestoreOperation
>;

/**
 * Pre-restore operation for checking whether the customer can perform a full restore operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.`v7.6_preview.2`)
@pollingOperation(restoreStatus)
@finalOperation(restoreStatus)
@useFinalStateVia("azure-async-operation")
@route("/prerestore")
@put
op preFullRestoreOperation is KeyVaultOperation<
  {
    /** Optional pre restore parameters to validate prior to performing a full restore operation. */
    @body preRestoreOperationParameters: PreRestoreOperationParameters;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The restore operation.
     */
    @body response: RestoreOperation;
  }
>;

/**
 * Restores all key materials using the SAS token pointing to a previously stored Azure Blob storage backup folder
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@pollingOperation(restoreStatus)
@finalOperation(restoreStatus)
@useFinalStateVia("azure-async-operation")
@route("/restore")
@put
op fullRestoreOperation is KeyVaultOperation<
  {
    /** The Azure blob SAS token pointing to a folder where the previous successful full backup was stored. */
    @body restoreBlobDetails: RestoreOperationParameters;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The restore operation.
     */
    @body response: RestoreOperation;
  }
>;

/**
 * Returns the status of the selective key restore operation
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@sharedRoute
@route("/restore/{jobId}/pending")
@get
op selectiveKeyRestoreStatus is KeyVaultOperation<
  {
    /**
     * The Job Id returned part of the restore operation
     */
    @path
    jobId: string;
  },
  SelectiveKeyRestoreOperation
>;

/**
 * Restores all key versions of a given key using user supplied SAS token pointing to a previously stored Azure Blob storage backup folder
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@pollingOperation(selectiveKeyRestoreStatus)
@finalOperation(selectiveKeyRestoreStatus)
@useFinalStateVia("azure-async-operation")
@route("/keys/{keyName}/restore")
@put
op selectiveKeyRestoreOperation is KeyVaultOperation<
  {
    /**
     * The name of the key to be restored from the user supplied backup
     */
    @path
    keyName: string;

    /**
     * The Azure blob SAS token pointing to a folder where the previous successful full backup was stored
     */
    @body
    restoreBlobDetails: SelectiveKeyRestoreOperationParameters;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The restore operation.
     */
    @body response: SelectiveKeyRestoreOperation;
  }
>;
