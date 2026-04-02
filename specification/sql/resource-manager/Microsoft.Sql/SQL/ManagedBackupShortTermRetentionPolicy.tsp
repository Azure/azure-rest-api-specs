import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A short term retention policy.
 */
@parentResource(ManagedDatabase)
model ManagedBackupShortTermRetentionPolicy
  is Azure.ResourceManager.ProxyResource<ManagedBackupShortTermRetentionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ManagedBackupShortTermRetentionPolicy,
    KeyName = "policyName",
    SegmentName = "backupShortTermRetentionPolicies",
    NamePattern = "",
    Type = ManagedShortTermRetentionPolicyName
  >;
}

alias ManagedBackupShortTermRetentionPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the managed instance. */
    @path
    @segment("managedInstances")
    @key
    managedInstanceName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;
  },
  {
    /** The policy name. */
    @path
    @segment("backupShortTermRetentionPolicies")
    @key
    policyName: ManagedShortTermRetentionPolicyName;
  }
>;

@armResourceOperations
interface ManagedBackupShortTermRetentionPolicies {
  /**
   * Gets a managed database's short term retention policy.
   */
  get is ManagedBackupShortTermRetentionPolicyOps.Read<ManagedBackupShortTermRetentionPolicy>;

  /**
   * Updates a managed database's short term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ManagedBackupShortTermRetentionPolicyOps.CreateOrUpdateAsync<
    ManagedBackupShortTermRetentionPolicy,
    Response = ArmResourceUpdatedResponse<ManagedBackupShortTermRetentionPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedBackupShortTermRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates a managed database's short term retention policy.
   */
  @patch(#{ implicitOptionality: false })
  update is ManagedBackupShortTermRetentionPolicyOps.CustomPatchAsync<
    ManagedBackupShortTermRetentionPolicy,
    PatchModel = ManagedBackupShortTermRetentionPolicy
  >;

  /**
   * Gets a managed database's short term retention policy list.
   */
  listByDatabase is ManagedBackupShortTermRetentionPolicyOps.List<ManagedBackupShortTermRetentionPolicy>;
}
alias ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the managed instance. */
    @path
    @segment("managedInstances")
    @key
    managedInstanceName: string;

    /**  */
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("restorableDroppedDatabases")
    @key
    restorableDroppedDatabaseId: string;
  },
  {
    /** The policy name. */
    @path
    @segment("backupShortTermRetentionPolicies")
    @key
    policyName: ManagedShortTermRetentionPolicyName;
  }
>;

@armResourceOperations
interface ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies {
  /**
   * Gets a dropped database's short term retention policy.
   */
  get is ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicyOps.Read<ManagedBackupShortTermRetentionPolicy>;

  /**
   * Sets a database's short term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicyOps.CreateOrUpdateAsync<
    ManagedBackupShortTermRetentionPolicy,
    Response = ArmResourceUpdatedResponse<ManagedBackupShortTermRetentionPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedBackupShortTermRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Sets a database's short term retention policy.
   */
  @patch(#{ implicitOptionality: false })
  update is ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicyOps.CustomPatchAsync<
    ManagedBackupShortTermRetentionPolicy,
    PatchModel = ManagedBackupShortTermRetentionPolicy
  >;

  /**
   * Gets a dropped database's short term retention policy list.
   */
  listByRestorableDroppedDatabase is ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicyOps.List<ManagedBackupShortTermRetentionPolicy>;
}

@@doc(ManagedBackupShortTermRetentionPolicy.name, "The policy name.");
@@doc(ManagedBackupShortTermRetentionPolicy.properties, "Resource properties.");
@@doc(ManagedBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The short term retention policy info."
);
@@doc(ManagedBackupShortTermRetentionPolicies.update::parameters.properties,
  "The short term retention policy info."
);
@@doc(ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The short term retention policy info."
);
@@doc(ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.update::parameters.properties,
  "The short term retention policy info."
);
