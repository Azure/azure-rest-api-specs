import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * An associated tenant.
 */
@tenantResource
@parentResource(BillingAccount)
model AssociatedTenant
  is Azure.ResourceManager.ProxyResource<AssociatedTenantProperties> {
  ...ResourceNameParameter<
    Resource = AssociatedTenant,
    KeyName = "associatedTenantName",
    SegmentName = "associatedTenants",
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface AssociatedTenants {
  /**
   * Gets an associated tenant by ID.
   */
  @tag("AssociatedTenant")
  get is ArmResourceRead<
    AssociatedTenant,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or update an associated tenant for the billing account.
   */
  @tag("AssociatedTenant")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AssociatedTenant,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = AssociatedTenant> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an associated tenant for a billing account.
   */
  @tag("AssociatedTenant")
  delete is ArmResourceDeleteWithoutOkAsync<
    AssociatedTenant,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the associated tenants that can collaborate with the billing account on commerce activities like viewing and downloading invoices, managing payments, making purchases, and managing or provisioning licenses.
   */
  @tag("AssociatedTenant")
  listByBillingAccount is ArmResourceListByParent<
    AssociatedTenant,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = AssociatedTenantsListByBillingAccountParameters,
    Response = ArmResponse<AssociatedTenantListResult>
  >;
}

alias AssociatedTenantsListByBillingAccountParameters = {
  /**
   * Can be used to get revoked associated tenants.
   */
  @query("includeRevoked")
  includeRevoked?: boolean = false;

  ...DefaultODataParameters;
};

@@doc(AssociatedTenant.name, "The ID that uniquely identifies a tenant.");
@@doc(AssociatedTenant.properties, "An associated tenant.");
@@doc(
  AssociatedTenants.createOrUpdate::parameters.resource,
  "An associated tenant."
);
