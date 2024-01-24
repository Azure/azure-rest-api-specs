import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Backup policy information
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NetAppAccount)
@Azure.ResourceManager.Private.armResourceInternal(BackupPolicyProperties)
@includeInapplicableMetadataInPayload(false)
model BackupPolicy extends TrackedResourceBase {
  /**
   * Backup policy Name which uniquely identify backup policy.
   */
  @path
  @key("backupPolicyName")
  @segment("backupPolicies")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Backup policy Properties
   */
  @extension("x-ms-client-flatten", true)
  properties: BackupPolicyProperties;
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
  create is ArmResourceCreateOrReplaceAsync<
    BackupPolicy,
    BaseParameters<BackupPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch a backup policy for Netapp Account
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    BackupPolicy,
    BackupPolicyPatch,
    BaseParameters<BackupPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete backup policy
   */
  delete is ArmResourceDeleteAsync<
    BackupPolicy,
    BaseParameters<BackupPolicy>,
    ArmLroLocationHeader
  >;

  /**
   * List backup policies for Netapp Account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupPolicies_List")
  list is ArmResourceListByParent<BackupPolicy>;
}

@@projectedName(BackupPolicies.create::parameters.resource, "json", "body");
@@extension(BackupPolicies.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(BackupPolicies.create::parameters.resource,
  "Backup policy object supplied in the body of the operation."
);
@@projectedName(BackupPolicies.update::parameters.properties, "json", "body");
@@extension(BackupPolicies.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(BackupPolicies.update::parameters.properties,
  "Backup policy object supplied in the body of the operation."
);
