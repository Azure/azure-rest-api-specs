import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Credit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Credit source resource definition
 */
@parentResource(Credit)
model CreditSource
  is Azure.ResourceManager.TrackedResource<CreditSourceProperties> {
  ...ResourceNameParameter<
    Resource = CreditSource,
    KeyName = "sourceName",
    SegmentName = "sources",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type. E.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Plan for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  plan?: Plan;
}

@armResourceOperations
interface CreditSources {
  /**
   * Get a credit source.
   */
  get is ArmResourceRead<CreditSource>;

  /**
   * Create a credit source.
   */
  create is ArmResourceCreateOrReplaceSync<CreditSource>;

  /**
   * Update a credit source.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    CreditSource,
    PatchModel = CreditSourcePatchRequest
  >;

  /**
   * Delete a credit source.
   */
  delete is ArmResourceDeleteSync<CreditSource>;

  /**
   * List credit sources for a credit under a resource group from primary service admin.
   */
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
