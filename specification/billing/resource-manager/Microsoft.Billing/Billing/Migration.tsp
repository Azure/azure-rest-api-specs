import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Microsoft.Billing;

/**
 * A migration mapping details.
 */
@singleton("default")
@tenantResource
@parentResource(BillingAccount)
model MigrationDetails
  is Azure.ResourceManager.ProxyResource<MigrationDetailsProperties> {
  ...ResourceNameParameter<
    Resource = MigrationDetails,
    KeyName = "migration",
    SegmentName = "migrations",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Migrations by design cannot be deleted because they are not a living resource."
@armResourceOperations(#{ omitTags: true })
interface Migrations {
  /**
   * Gets migration mapping details.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Migration")
  get is ArmResourceRead<
    MigrationDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Migrates from source to destination billing scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing migration endpoint returns only 200."
  @added(Versions.v2024_08_01_preview)
  @tag("Migration")
  put is ArmResourceCreateOrReplaceAsync<
    MigrationDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = MigrationDetails> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResponse<MigrationDetails>
  >;
}
