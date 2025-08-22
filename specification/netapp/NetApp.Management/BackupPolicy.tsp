import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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
  create is ArmResourceCreateOrReplaceAsync<
    BackupPolicy,
    Response = ArmResourceUpdatedResponse<BackupPolicy> | ArmResourceCreatedResponse<BackupPolicy> | ArmAcceptedLroResponse
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
