import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./capability.models.tsp";
import "./target.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@armResourceOperations
interface Capabilities {
  /**
   * Get a Capability resource that extends a Target resource.
   */
  get is ArmResourceRead<Capability, CapabilityParentResourceParameters>;

  /**
   * Create or update a Capability resource that extends a Target resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Capability,
    CapabilityParentResourceParameters
  >;

  /**
   * Delete a Capability that extends a Target resource.
   */
  delete is ArmResourceDeleteSync<
    Capability,
    CapabilityParentResourceParameters
  >;

  /**
   * Get a list of Capability resources that extend a Target resource.
   */
  list is ArmResourceListByParent<
    Capability,
    {
      ...CapabilityParentResourceParameters;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = CapabilityListResult
  >;
}

@@doc(Capability.name, "String that represents a Capability resource name.");
@@doc(Capability.properties, "The properties of a capability resource.");
@@doc(Capabilities.createOrUpdate::parameters.resource,
  "Capability resource to be created or updated."
);
