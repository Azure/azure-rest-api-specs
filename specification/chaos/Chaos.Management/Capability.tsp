import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Target.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

alias ParentedResourceParameters = BaseParameters<Capability> & {
  @path
  @segment("providers")
  parentProviderNamespace: string;

  @path
  parentResourceType: string;
};

/**
 * Model that represents a Capability resource.
 */
@parentResource(Target)
model Capability is ProxyResource<CapabilityProperties> {
  /**
   * String that represents a Capability resource name.
   */
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityName")
  @segment("capabilities")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Capabilities {
  /**
   * Get a Capability resource that extends a Target resource.
   */
  get is ArmResourceRead<Capability>;

  /**
   * Create or update a Capability resource that extends a Target resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Capability>;

  /**
   * Delete a Capability that extends a Target resource.
   */
  delete is ArmResourceDeleteSync<Capability>;

  /**
   * Get a list of Capability resources that extend a Target resource..
   */
  list is ArmResourceListByParent<
    Capability,
    {
      ...ParentedResourceParameters;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

@@doc(Capabilities.createOrUpdate::parameters.resource,
  "Capability resource to be created or updated."
);
