import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureActiveDirectory;
/**
 * Ciam Directory Resource
 */
model CiamDirectoryResource is TrackedResource<CiamDirectoryProperties> {
  /**
   * The initial domain name of the Azure AD B2C tenant.
   */
  @path
  @key("resourceName")
  @segment("ciamDirectories")
  @visibility("read")
  @pattern("^[a-zA-Z0-9.]+")
  @maxLength(43)
  @minLength(1)
  name: string;

  ...CiamCustomResourceSku;
}

/**
 * Properties of the Azure AD for customers tenant Azure resource.
 */
model CiamDirectoryProperties {
  /**
   * Provisioning State
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * These properties are used to create the Azure AD for customers tenant. These properties are not part of the Azure resource.
   */
  createTenantProperties: CreateCiamTenantProperties;

  /**
   * The domain name of the tenant
   */
  @visibility("read")
  domainName?: string;

  /**
   * The billing configuration for the tenant.
   */
  @visibility("read")
  billingConfig?: CiamTenantResourcePropertiesBillingConfig;

  /**
   * An identifier of the Azure AD for customers tenant.
   */
  @visibility("read", "create")
  tenantId?: string;
}

/**
 * SKU properties of the Azure AD for customers tenant. Learn more about Azure AD for customers billing at [https://aka.ms/ciambilling](https://aka.ms/ciambilling).
 */
model CiamResourceSku {
  /**
   * The name of the SKU for the tenant.
   */
  name: CiamResourceSkuName;

  /**
   * The tier of the tenant.
   */
  @visibility("read", "create")
  tier: CiamResourceSKUTier;
}

/**
 * The name of the SKU for the tenant.
 */
union CiamResourceSkuName {
  string,
  Base: "Base",
}

/**
 * The tier of the tenant.
 */
union CiamResourceSKUTier {
  string,

  /**
   * The SKU tier used for all Azure AD for customers tenants.
   */
  A0: "A0",
}

/**
 * The type of billing. Will be MAU for all new customers. Cannot be changed if value is 'MAU'. Learn more about Azure AD for customers billing at [aka.ms/b2cBilling](https://aka.ms/b2cbilling).
 */
union CiamBillingType {
  string,

  /**
   * Azure AD for customers usage is billed to a linked Azure subscription and uses a monthly active users (MAU) billing model.
   */
  MAU: "MAU",
}

/**
 * These properties are used to create the Azure AD for customers tenant. These properties are not part of the Azure resource.
 */
model CreateCiamTenantProperties {
  /**
   * The display name of the Azure AD for customers tenant.
   */
  @visibility("read", "create")
  displayName: string;

  /**
   * Country code of Azure tenant (e.g. 'US'). Refer to [https://aka.ms/ciam-data-location](https://aka.ms/ciam-data-location) to see valid country codes and corresponding data residency locations. If you do not see a country code in an valid data residency location, choose one from the list.
   */
  @visibility("read", "create")
  countryCode: string;
}

/**
 * The billing configuration for the tenant.
 */
model CiamTenantResourcePropertiesBillingConfig {
  /**
   * The type of billing. Will be MAU for all new customers. Cannot be changed if value is 'MAU'. Learn more about Azure AD for customers billing at [aka.ms/b2cBilling](https://aka.ms/b2cbilling).
   */
  @visibility("read")
  billingType?: CiamBillingType;

  /**
   * The data from which the billing type took effect
   */
  @visibility("read")
  effectiveStartDateUtc?: string;
}

/**
 * The request body to update the Azure AD for customers tenant resource.
 */
model CiamTenantUpdateRequest {
  /**
   * SKU properties of the Azure AD for customers tenant. Learn more about Azure AD for customers billing at [https://aka.ms/ciambilling](https://aka.ms/ciambilling).
   */
  sku?: CiamResourceSku;

  /**
   * Resource Tags
   */
  tags?: Record<string>;
}

/**
 * Ciam Directory Resource for Patch
 */
model CiamDirectoryResourcePatch {
  /**
   * Key-value pairs of additional resource provisioning properties.
   */
  tags?: Record<string>;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource
   */
  sku?: CiamResourceSku;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("The SKU (Stock Keeping Unit) assigned to this resource.")
model CiamCustomResourceSku {
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku: CiamResourceSku;
}

@armResourceOperations
interface CiamDirectoriesResources {
  /**
   * Gets a Ciam Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  get is ArmResourceRead<CiamDirectoryResource>;

  /**
   * Creates a Ciam Directory resource, which is used to linking a subscription to an instance of Azure AD External Identities. [Learn more](https://aka.ms/extidbilling).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CiamDirectoryResource>;

  /**
   * Updates a Ciam Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    CiamDirectoryResource,
    CiamDirectoryResourcePatch
  >;

  /**
   * Deletes a Ciam Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  delete is ArmResourceDeleteWithoutOkAsync<CiamDirectoryResource>;

  /**
   * Gets Ciam Directory resources under a resource group for the Microsoft.AzureActiveDirectory resource provider
   */
  listByResourceGroup is ArmResourceListByParent<CiamDirectoryResource>;

  /**
   * Gets Ciam Directory resources under a subscription for the Microsoft.AzureActiveDirectory resource provider
   */
  listBySubscription is ArmListBySubscription<CiamDirectoryResource>;
}
