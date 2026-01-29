import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

namespace Microsoft.NetApp;
/**
 * Backup policy information
 */
@parentResource(NetAppAccount)
model BackupPolicy
  is Azure.ResourceManager.TrackedResource<BackupPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = BackupPolicy,
    KeyName = "backupPolicyName",
    SegmentName = "backupPolicies",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

/**
 * List of Backup Policies
 */
model BackupPoliciesList is Azure.Core.Page<BackupPolicy>;

/**
 * Backup policy properties
 */
model BackupPolicyProperties {
  /**
   * Backup Policy GUID ID
   */
  @visibility(Lifecycle.Read)
  backupPolicyId?: string;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Daily backups count to keep
   */
  dailyBackupsToKeep?: int32;

  /**
   * Weekly backups count to keep
   */
  weeklyBackupsToKeep?: int32;

  /**
   * Monthly backups count to keep
   */
  monthlyBackupsToKeep?: int32;

  /**
   * Volumes using current backup policy
   */
  @visibility(Lifecycle.Read)
  volumesAssigned?: int32;

  /**
   * The property to decide policy is enabled or not
   */
  enabled?: boolean;

  /**
   * A list of volumes assigned to this policy
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["volumeName"])
  volumeBackups?: VolumeBackups[];
}

/**
 * Volume details using the backup policy
 */
model VolumeBackups {
  /**
   * Volume name
   */
  volumeName?: string;

  /**
   * ResourceId used to identify the Volume
   */
  volumeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Total count of backups for volume
   */
  backupsCount?: int32;

  /**
   * Policy enabled
   */
  policyEnabled?: boolean;
}

/**
 * Backup policy Details for create and update
 */
model BackupPolicyPatch {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Backup policy Properties
   */
  properties?: BackupPolicyProperties;
}

@armResourceOperations
interface BackupPolicies {
  /**
   * Get a particular backup Policy
   */
  get is ArmResourceRead<BackupPolicy>;

  /**
   * Create a backup policy for Netapp Account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    BackupPolicy,
    Response = ArmResourceUpdatedResponse<BackupPolicy> | ArmResourceCreatedResponse<
      BackupPolicy,
      ArmAsyncOperationHeader<FinalResult = BackupPolicy> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Patch a backup policy for Netapp Account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BackupPolicy,
    PatchModel = BackupPolicyPatch,
    Response = ArmResponse<BackupPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = BackupPolicy> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BackupPolicy;
    })
  >;

  /**
   * Delete backup policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BackupPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List backup policies for Netapp Account
   */
  list is ArmResourceListByParent<
    BackupPolicy,
    Response = ArmResponse<BackupPoliciesList>
  >;
}

@@doc(BackupPolicy.name,
  "Backup policy Name which uniquely identify backup policy."
);
@@doc(BackupPolicy.properties, "Backup policy Properties");
@@doc(BackupPolicies.create::parameters.resource,
  "Backup policy object supplied in the body of the operation."
);
@@doc(BackupPolicies.update::parameters.properties,
  "Backup policy object supplied in the body of the operation."
);
