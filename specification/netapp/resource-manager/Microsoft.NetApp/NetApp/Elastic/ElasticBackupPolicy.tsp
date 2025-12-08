import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Backup Policy resource
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ElasticAccount)
model ElasticBackupPolicy is TrackedResource<ElasticBackupPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ElasticBackupPolicy,
    KeyName = "backupPolicyName",
    SegmentName = "elasticBackupPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/**
 * Elastic Backup Policy properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticBackupPolicyProperties {
  /** Azure lifecycle management. */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /** Daily backups count to keep */
  @minValue(2)
  @maxValue(1017)
  dailyBackupsToKeep?: int32;

  /** Weekly backups count to keep */
  @minValue(0)
  @maxValue(1019)
  weeklyBackupsToKeep?: int32;

  /** Monthly backups count to keep */
  @minValue(0)
  @maxValue(1019)
  monthlyBackupsToKeep?: int32;

  /** The number of volumes currently using this Backup Policy. */
  @visibility(Lifecycle.Read)
  assignedVolumesCount?: int32;

  /** The property to identify whether Backup Policy is enabled or not */
  policyState?: ElasticBackupPolicyState;
}

/**
 * Elastic Backup Policy state
 */
@added(Versions.v2025_09_01_preview)
union ElasticBackupPolicyState {
  string,

  /** Value indicating the policy is enabled */
  Enabled: "Enabled",

  /** Value indicating the policy is disabled */
  Disabled: "Disabled",
}

@armResourceOperations
interface ElasticBackupPolicies {
  /**
   * Get the Elastic Backup Policy
   */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ElasticBackupPolicy>;

  /**
   * Create or update the specified Elastic Backup Policy in the NetApp account
   */
  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticBackupPolicy>;

  /**
   * Patch the specified NetApp Elastic Backup Policy
   */
  @added(Versions.v2025_09_01_preview)
  update is ArmCustomPatchAsync<
    ElasticBackupPolicy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticBackupPolicy,
      ElasticBackupPolicyProperties
    >
  >;

  /**
   * Delete the specified Elastic Policy
   */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBackupPolicy>;
  /**
   * List and describe all Elastic Backup Policies in the elastic account.
   */
  @added(Versions.v2025_09_01_preview)
  listByElasticAccount is ArmResourceListByParent<ElasticBackupPolicy>;
}

@@clientName(ElasticBackupPolicies.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticBackupPolicies.update::parameters.properties, "body");

@@maxLength(ElasticBackupPolicy.name, 64);
@@minLength(ElasticBackupPolicy.name, 1);
