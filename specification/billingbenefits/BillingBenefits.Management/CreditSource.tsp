import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Credit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;
/**
 * Credit source resource definition
 */
@added(Versions.v2025_05_01_preview)
@parentResource(Credit)
model CreditSource
  is Azure.ResourceManager.TrackedResource<CreditSourceProperties> {
  ...ResourceNameParameter<
    Resource = CreditSource,
    KeyName = "sourceName",
    SegmentName = "sources",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
@added(Versions.v2025_05_01_preview)
interface CreditSources {
  /**
   * Get a credit source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sources_Get")
  get is ArmResourceRead<CreditSource>;

  /**
   * Create a credit source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sources_Create")
  create is ArmResourceCreateOrReplaceSync<CreditSource>;

  /**
   * Update a credit source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Sources_Update")
  update is ArmCustomPatchSync<
    CreditSource,
    PatchModel = CreditSourcePatchRequest
  >;

  /**
   * Delete a credit source.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sources_Delete")
  delete is ArmResourceDeleteSync<CreditSource>;

  /**
   * List credit sources for a credit under a resource group from primary service admin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sources_ListByCredit")
  listByCredit is ArmResourceListByParent<
    CreditSource,
    Response = ArmResponse<CreditSourcesList>
  >;
}

@@doc(CreditSource.name, "Name of the credit source");
@@doc(CreditSource.properties, "Credit source properties");
@@doc(CreditSources.create::parameters.resource,
  "Credit source create request"
);
@@doc(CreditSources.update::parameters.properties,
  "Credit source patch request"
);
