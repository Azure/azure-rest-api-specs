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
 * Guest Usages Resource
 */
model GuestUsagesResource is TrackedResource<GuestUsagesResourceProperties> {
  /**
   * The initial domain name of the Azure AD B2C tenant.
   */
  @path
  @key("resourceName")
  @segment("guestUsages")
  @visibility("read")
  @pattern("^[a-zA-Z0-9.]+")
  name: string;
}

/**
 * Guest Usages Resource Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model GuestUsagesResourceProperties {
  /**
   * An identifier for the tenant for which the resource is being created
   */
  tenantId?: string;
}

/**
 * Guest Usages Resource for Patch
 */
model GuestUsagesResourcePatch {
  /**
   * Key-value pairs of additional resource provisioning properties.
   */
  tags?: Record<string>;
}

@armResourceOperations
interface GuestUsagesResources {
  /**
   * Gets a Guest Usages resource for the Microsoft.AzureActiveDirectory resource provider
   */
  get is ArmResourceRead<GuestUsagesResource>;

  /**
   * Creates a Guest Usages resource, which is used to linking a subscription to an instance of Azure AD External Identities. [Learn more](https://aka.ms/extidbilling).
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<GuestUsagesResource>;

  /**
   * Updates a Guest Usages resource for the Microsoft.AzureActiveDirectory resource provider
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<GuestUsagesResource, GuestUsagesResourcePatch>;

  /**
   * Deletes a Guest Usages resource for the Microsoft.AzureActiveDirectory resource provider
   */
  delete is ArmResourceDeleteSync<GuestUsagesResource>;

  /**
   * Gets Guest Usages resources under a resource group for the Microsoft.AzureActiveDirectory resource provider
   */
  listByResourceGroup is ArmResourceListByParent<GuestUsagesResource>;

  /**
   * Gets Guest Usages resources under a subscription for the Microsoft.AzureActiveDirectory resource provider
   */
  listBySubscription is ArmListBySubscription<GuestUsagesResource>;
}
