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
 * B2C Directory Resource
 */
model B2cDirectoryResource is TrackedResource<B2cDirectoryResourceProperties> {
  /**
   * The initial domain name of the Azure AD B2C tenant.
   */
  @path
  @key("resourceName")
  @segment("b2cDirectories")
  @visibility("read")
  @pattern("^[a-zA-Z0-9.]+")
  @maxLength(43)
  @minLength(1)
  name: string;

  ...B2cCustomResourceSku;
}

/**
 * Properties of the Azure AD B2C tenant Azure resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Legacy API"
model B2cDirectoryResourceProperties {
  /**
   * The billing configuration for the tenant.
   */
  billingConfig?: B2cTenantResourcePropertiesBillingConfig;

  /**
   * An identifier of the Azure AD B2C tenant.
   */
  tenantId?: string;

  /**
   * Enable GoLocal add-on to store data at rest in the specific Geo. Refer to [aka.ms/B2CDataResidency](https://aka.ms/B2CDataResidency) to see local data residency options.
   */
  isGoLocalTenant?: boolean;
}

/**
 * The billing configuration for the tenant.
 */
model B2cTenantResourcePropertiesBillingConfig {
  /**
   * The type of billing. Will be MAU for all new customers. If 'Auths', it can be updated to 'MAU'. Cannot be changed if value is 'MAU'. Learn more about Azure AD B2C billing at [aka.ms/b2cBilling](https://aka.ms/b2cbilling).
   */
  billingType?: BillingType;

  /**
   * The data from which the billing type took effect
   */
  @visibility("read")
  effectiveStartDateUtc?: string;
}

/**
 * The request body to update the Azure AD B2C tenant resource.
 */
model B2cDirectoryResourcePatch {
  /**
   * The billing configuration for the tenant.
   */
  billingConfig?: B2cTenantResourcePropertiesBillingConfig;

  /**
   * An identifier of the Azure AD B2C tenant.
   */
  tenantId?: string;

  /**
   * Enable GoLocal add-on to store data at rest in the specific Geo. Refer to [aka.ms/B2CDataResidency](https://aka.ms/B2CDataResidency) to see local data residency options.
   */
  isGoLocalTenant?: boolean;
}

/**
 * SKU properties of the Azure AD B2C tenant. Learn more about Azure AD B2C billing at [aka.ms/b2cBilling](https://aka.ms/b2cBilling).
 */
model B2cResourceSku {
  /**
   * The name of the SKU for the tenant.
   */
  name?: B2CResourceSKUName;

  /**
   * The tier of the tenant.
   */
  tier?: B2CResourceSKUTier;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("The SKU (Stock Keeping Unit) assigned to this resource.")
model B2cCustomResourceSku {
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku: B2cResourceSku;
}

/**
 * The tier of the tenant.
 */
union B2CResourceSKUTier {
  string,

  /**
   * The SKU tier used for all Azure AD B2C tenants.
   */
  A0: "A0",
}

/**
 * The type of billing. Will be MAU for all new customers. If 'Auths', it can be updated to 'MAU'. Cannot be changed if value is 'MAU'. Learn more about Azure AD B2C billing at [aka.ms/b2cBilling](https://aka.ms/b2cbilling).
 */
union BillingType {
  string,

  /**
   * Azure AD B2C usage is billed to a linked Azure subscription and uses a monthly active users (MAU) billing model.
   */
  MAU: "MAU",

  /**
   * Azure AD B2C usage is billed to a linked Azure subscription and uses number of authentications based billing.
   */
  Auths: "Auths",
}

/**
 * The name of the SKU for the tenant.
 */
union B2CResourceSKUName {
  string,

  /**
   * Azure AD B2C usage is billed to a linked Azure subscription and uses a monthly active users (MAU) billing model.
   */
  Standard: "Standard",

  /**
   * Azure AD B2C usage is billed to a linked Azure subscription and uses number of authentications based billing.
   */
  PremiumP1: "PremiumP1",

  /**
   * Azure AD B2C usage is billed to a linked Azure subscription and uses number of authentications based billing.
   */
  PremiumP2: "PremiumP2",
}

@armResourceOperations
interface B2cDirectoriesResources {
  /**
   * Gets a B2c Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  get is ArmResourceRead<B2cDirectoryResource>;

  /**
   * Creates a B2c Directory resource, which is used to linking a subscription to an instance of Azure AD External Identities. [Learn more](https://aka.ms/extidbilling).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy API"
  createOrUpdate is ArmResourceCreateOrUpdateAsyncWithAccepted<B2cDirectoryResource>;

  /**
   * Updates a B2c Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  @parameterVisibility("read")
  update is ArmResourcePatchSync<
    B2cDirectoryResource,
    B2cDirectoryResourcePatch
  >;

  /**
   * Deletes a B2c Directory resource for the Microsoft.AzureActiveDirectory resource provider
   */
  delete is ArmResourceDeleteWithoutOkAsync<B2cDirectoryResource>;

  /**
   * Gets B2c Directory resources under a resource group for the Microsoft.AzureActiveDirectory resource provider
   */
  listByResourceGroup is ArmResourceListByParent<B2cDirectoryResource>;

  /**
   * Gets B2c Directory resources under a subscription for the Microsoft.AzureActiveDirectory resource provider
   */
  listBySubscription is ArmListBySubscription<B2cDirectoryResource>;
}

/**
 * @dev Create a resource asynchronously
 * @template Resource The resource being deleted
 * @template Response The response type for the operation
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "this is a template"
@autoRoute
@doc("Create a {name}", Resource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceCreateOrUpdate(Resource)
@put
op ArmResourceCreateOrUpdateAsyncWithAcceptedBase<
  Resource extends ArmResource,
  Request extends TypeSpec.Reflection.Model | void,
  Response,
  BaseParameters = DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  @doc("Resource create parameters.") @body resource: Resource,
): Response | Error;

/**
 * @dev Creae a resource asynchronously.
 * @template Resource The resource being deleted
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template LroHeaders Optional. Allows overriding the headers in the Accepted response
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response(s) for the delete operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "this is a template"
op ArmResourceCreateOrUpdateAsyncWithAccepted<
  Resource extends ArmResource,
  BaseParameters = DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
> is ArmResourceCreateOrUpdateAsyncWithAcceptedBase<
  Resource,
  TypeSpec.Reflection.Model | void,
  ArmResourceUpdatedResponse<Resource> | ArmAcceptedLroResponse<
    "Resource operation accepted.",
    LroHeaders
  >,
  BaseParameters,
  Parameters,
  Error
>;
