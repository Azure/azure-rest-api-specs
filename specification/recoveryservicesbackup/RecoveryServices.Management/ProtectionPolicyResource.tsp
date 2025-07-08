import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup policy. Workload-specific backup policies are derived from this class.
 */
@parentResource(VaultResource)
model ProtectionPolicyResource
  is Azure.ResourceManager.TrackedResource<ProtectionPolicy> {
  ...ResourceNameParameter<
    Resource = ProtectionPolicyResource,
    KeyName = "policyName",
    SegmentName = "backupPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectionPolicies {
  /**
   * Provides the details of the backup policies associated to Recovery Services Vault. This is an asynchronous
   * operation. Status of the operation can be fetched using GetPolicyOperationResult API.
   */
  get is ArmResourceRead<ProtectionPolicyResource>;

  /**
   * Creates or modifies a backup policy. This is an asynchronous operation. Status of the operation can be fetched
   * using GetPolicyOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ProtectionPolicyResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<ProtectionPolicyResource> | AcceptedResponse
  >;

  /**
   * Deletes specified backup policy from your Recovery Services Vault. This is an asynchronous operation. Status of the
   * operation can be fetched using GetProtectionPolicyOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteAsyncBase<
    ProtectionPolicyResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface BackupPolicies {
  /**
   * Lists of backup policies associated with Recovery Services Vault. API provides pagination parameters to fetch
   * scoped results.
   */
  list is ArmResourceListByParent<
    ProtectionPolicyResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ProtectionPolicyResourceList>
  >;
}

@armResourceOperations
interface ProtectionPolicyOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionPolicyResource,
          KeyName = "policyName",
          SegmentName = "backupPolicies",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectionPolicyResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectionPolicyOperationResults {
  /**
   * Provides the result of an operation.
   */
  get is ProtectionPolicyOperationResultOps.Read<ProtectionPolicyResource>;
}

@armResourceOperations
interface ProtectionPolicyOperationStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionPolicyResource,
          KeyName = "policyName",
          SegmentName = "backupPolicies",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectionPolicyResource,
        KeyName = "operationId",
        SegmentName = "operations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectionPolicyOperationStatuses {
  /**
   * Provides the status of the asynchronous operations like backup, restore. The status can be in progress, completed
   * or failed. You can refer to the Operation Status enum for all the possible states of an operation. Some operations
   * create jobs. This method returns the list of jobs associated with operation.
   */
  @get
  get is ProtectionPolicyOperationStatusOps.Read<OperationStatus>;
}

@@doc(ProtectionPolicyResource.name,
  "Backup policy information to be fetched."
);
@@doc(ProtectionPolicyResource.properties,
  "ProtectionPolicyResource properties"
);
@@doc(ProtectionPolicies.createOrUpdate::parameters.resource,
  "resource backup policy"
);
