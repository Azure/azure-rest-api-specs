import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model ResourceTypeRegistration
  is Azure.ResourceManager.ProxyResource<ResourceTypeRegistrationProperties> {
  ...ResourceNameParameter<
    Resource = ResourceTypeRegistration,
    KeyName = "resourceType",
    SegmentName = "resourcetypeRegistrations",
    NamePattern = ""
  >;

  /**
   * Resource type registration kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ResourceTypeRegistrationKind = ResourceTypeRegistrationKind.Managed;
}

@armResourceOperations
interface ResourceTypeRegistrations {
  /**
   * Gets a resource type details in the given subscription and provider.
   */
  get is ArmResourceRead<ResourceTypeRegistration>;

  /**
   * Creates or updates a resource type.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ResourceTypeRegistration>;

  /**
   * Deletes a resource type
   */
  delete is ArmResourceDeleteWithoutOkAsync<ResourceTypeRegistration>;

  /**
   * Gets the list of the resource types for the given provider.
   */
  listByProviderRegistration is ArmResourceListByParent<
    ResourceTypeRegistration,
    Response = ArmResponse<ResourceTypeRegistrationArrayResponseWithContinuation>
  >;
}

@@doc(ResourceTypeRegistration.name, "The resource type.");
@@doc(ResourceTypeRegistration.properties, "");
@@doc(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "The required request body parameters supplied to the resource type registration CreateOrUpdate operation."
);
