import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Security.KeyVault.Common/common.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;

/**
 * An authentication method and location for the operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Model name has already shipped"
model SASTokenParameter {
  /**
   * Azure Blob storage container Uri
   */
  storageResourceUri: string;

  /**
   * The SAS token pointing to an Azure Blob storage container
   */
  token?: string;

  /**
   * Indicates which authentication method should be used. If set to true, Managed HSM will use the configured user-assigned managed identity to authenticate with Azure Storage. Otherwise, a SAS token has to be specified.
   */
  useManagedIdentity?: boolean = false;
}

/**
 * The status of a long-running operation.
 */
@lroStatus
union OperationStatus {
  string,

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation successfully completed. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",
}

/**
 * Full backup operation
 */
model FullBackupOperation {
  /**
   * Status of the backup operation.
   */
  status?: OperationStatus;

  /**
   * The status details of backup operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the full backup operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
  error?: Error;

  /**
   * The start time of the backup operation in UTC
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the backup operation in UTC
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable attribute"
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime | null;

  /**
   * Identifier for the full backup operation.
   */
  jobId?: string;

  /**
   * The Azure blob storage container Uri which contains the full backup
   */
  azureStorageBlobContainerUri?: string;
}

/**
 * The authentication method and location for the backup operation.
 */
@added(KeyVault.Versions.`v7.6_preview.2`)
model PreBackupOperationParameters {
  /**
   * Azure Blob storage container Uri
   */
  storageResourceUri?: string;

  /**
   * The SAS token pointing to an Azure Blob storage container
   */
  token?: string;

  /**
   * Indicates which authentication method should be used. If set to true, Managed HSM will use the configured user-assigned managed identity to authenticate with Azure Storage. Otherwise, a SAS token has to be specified.
   */
  useManagedIdentity?: boolean = false;
}

/**
 * The authentication method and location for the restore operation.
 */
@added(KeyVault.Versions.`v7.6_preview.2`)
model PreRestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters?: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folderToRestore?: string;
}

/**
 * Restore operation
 */
model RestoreOperation {
  /**
   * Status of the restore operation.
   */
  status?: OperationStatus;

  /**
   * The status details of restore operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the restore operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
  error?: Error;

  /**
   * Identifier for the restore operation.
   */
  jobId?: string;

  /**
   * The start time of the restore operation
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the restore operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable attribute"
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime | null;
}

/**
 * The authentication method and location for the restore operation.
 */
model RestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folderToRestore: string;
}

/**
 * The authentication method and location for the selective key restore operation.
 */
model SelectiveKeyRestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folder: string;
}

/**
 * Selective Key Restore operation
 */
model SelectiveKeyRestoreOperation {
  /**
   * Status of the restore operation.
   */
  status?: OperationStatus;

  /**
   * The status details of restore operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the selective key restore operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
  error?: Error;

  /**
   * Identifier for the selective key restore operation.
   */
  jobId?: string;

  /**
   * The start time of the restore operation
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the restore operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable attribute"
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime | null;
}
