import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Service-set extensible enumeration indicating the status of operation.
 */
union ExecutionStatus {
  string,

  /** Operation is currently running. */
  Running: "Running",

  /** Operation has been cancelled. */
  Cancelled: "Cancelled",

  /** Operation has failed. */
  Failed: "Failed",

  /** Operation has succeeded. */
  Succeeded: "Succeeded",
}

/**
 * A request that is made for pre-backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LtrPreBackupRequest extends BackupRequestBase {}

/**
 * BackupRequestBase is the base for all backup request.
 */
model BackupRequestBase {
  /**
   * Backup Settings
   */
  backupSettings: BackupSettings;
}

/**
 * Settings for the long term backup.
 */
model BackupSettings {
  /**
   * Backup Name for the current backup
   */
  backupName: string;
}

/**
 * Response for the LTR pre-backup API call.
 */
model LtrPreBackupResponse {
  /**
   * Additional Properties for the pre backup response
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: BackupsLongTermRetentionResponseProperties;
}

/**
 * Response for the pre-backup request.
 */
model BackupsLongTermRetentionResponseProperties {
  /**
   * Number of storage containers the plugin will use during backup. More than one containers may be used for size limitations, parallelism, or redundancy etc.
   */
  numberOfContainers: int32;
}

/**
 * Request made for a long term retention backup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupsLongTermRetentionRequest extends BackupRequestBase {
  /**
   * Backup store detail for target server.
   */
  targetDetails: BackupStoreDetails;
}

/**
 * Details about the target where the backup content will be stored.
 */
model BackupStoreDetails {
  /**
   * List of SAS uri of storage containers where backup data is to be streamed/copied.
   */
  sasUriList: secretString[];
}

/**
 * Response for the LTR backup API call
 */
model BackupsLongTermRetentionResponse {
  /**
   * Long Term Retention Backup Operation Resource Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: LtrBackupOperationResponseProperties;
}

/**
 * Response for the backup request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LtrBackupOperationResponseProperties {
  /**
   * Size of datasource in bytes.
   */
  datasourceSizeInBytes?: int64;

  /**
   * Data transferred in bytes.
   */
  dataTransferredInBytes?: int64;

  /**
   * Name of Backup operation.
   */
  backupName?: string;

  /**
   * Metadata to be stored in RP. Store everything that will be required to perform a successful restore using this Recovery point. e.g. Versions, DataFormat etc.
   */
  backupMetadata?: string;

  /**
   * Service-set extensible enum indicating the status of operation.
   */
  status: ExecutionStatus;

  /**
   * Start time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * End time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Percentage completed.
   */
  @minValue(0)
  @maxValue(100)
  percentComplete?: float64;

  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * A list of long term retention backup operations for server.
 */
model LtrServerBackupOperationList
  is Azure.Core.Page<BackupsLongTermRetentionOperation>;

@secret
scalar secretString extends string;

/**
 * Response for the LTR backup Operation API call
 */
@parentResource(Server)
model BackupsLongTermRetentionOperation
  is Azure.ResourceManager.ProxyResource<LtrBackupOperationResponseProperties> {
  ...ResourceNameParameter<
    Resource = BackupsLongTermRetentionOperation,
    KeyName = "backupName",
    SegmentName = "ltrBackupOperations",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;
}

alias BackupsLongTermRetentionOperationAlias = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<BackupsLongTermRetentionOperation>;
    ...ParentKeysOf<BackupsLongTermRetentionOperation>;
  },
  {
    /**
     * The name of the backup.
     */
    @path
    @segment("ltrBackupOperations")
    @minLength(1)
    @maxLength(128)
    @pattern("^[-\\w\\._]+$")
    backupName: string;
  },
  ErrorType = ErrorResponse
>;

@armResourceOperations
interface BackupsLongTermRetentionOperations {
  /**
   * Gets the results of a long retention backup operation for a server.
   */
  get is BackupsLongTermRetentionOperationAlias.Read<BackupsLongTermRetentionOperation>;

  /**
   * Lists the results of the long term retention backup operations for a server.
   */
  listByServer is ArmResourceListByParent<
    BackupsLongTermRetentionOperation,
    Response = ArmResponse<LtrServerBackupOperationList>
  >;
}

@@doc(BackupsLongTermRetentionOperation.name, "The name of the backup.");
@@doc(
  BackupsLongTermRetentionOperation.properties,
  "Long Term Retention Backup Operation Resource Properties"
);
