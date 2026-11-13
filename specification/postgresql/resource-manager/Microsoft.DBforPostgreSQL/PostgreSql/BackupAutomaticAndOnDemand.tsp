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

namespace Microsoft.DBforPostgreSQL;

/**
 * Type of backup.
 */
union BackupType {
  string,

  /** A full backup taken automatically by the service. These backups are retained for a period of time as defined by the backup retention policy, and they cannot be deleted by the customer. */
  Full: "Full",

  /** A full backup triggered by the customer. These backups are retained for a period of time as defined by the backup retention policy, and they can also be deleted by the customer. */
  `Customer On-Demand`: "Customer On-Demand",
}

/**
 * Properties of a backup.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupAutomaticAndOnDemandProperties {
  /**
   * Type of backup.
   */
  backupType?: BackupType;

  /**
   * Time(ISO8601 format) at which the backup was completed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedTime?: utcDateTime;

  /**
   * Source of the backup.
   */
  source?: string;
}

/**
 * List of backups.
 */
model BackupAutomaticAndOnDemandList
  is Azure.Core.Page<BackupAutomaticAndOnDemand>;

/**
 * Properties of a backup.
 */
@parentResource(Server)
model BackupAutomaticAndOnDemand
  is Azure.ResourceManager.ProxyResource<BackupAutomaticAndOnDemandProperties> {
  ...ResourceNameParameter<
    Resource = BackupAutomaticAndOnDemand,
    KeyName = "backupName",
    SegmentName = "backups",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface BackupAutomaticAndOnDemands {
  /**
   * Gets information of an on demand backup, given its name.
   */
  get is ArmResourceRead<BackupAutomaticAndOnDemand>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates an on demand backup of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is Legacy.CreateOrReplaceAsync<
    BackupAutomaticAndOnDemand,
    Request = void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = BackupAutomaticAndOnDemand> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes a specific backup, given its name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BackupAutomaticAndOnDemand,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all available backups of a server.
   */
  listByServer is ArmResourceListByParent<
    BackupAutomaticAndOnDemand,
    Response = ArmResponse<BackupAutomaticAndOnDemandList>
  >;
}

@@maxLength(BackupAutomaticAndOnDemand.name, 128);
@@minLength(BackupAutomaticAndOnDemand.name, 1);
@@doc(BackupAutomaticAndOnDemand.name, "Name of the backup.");
@@doc(BackupAutomaticAndOnDemand.properties, "Properties of a backup.");
