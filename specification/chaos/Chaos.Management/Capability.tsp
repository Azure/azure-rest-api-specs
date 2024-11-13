import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Target.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Capability resource.
 */
@parentResource(Target)
model Capability is Azure.ResourceManager.ProxyResource<CapabilityProperties> {
  ...ResourceNameParameter<
    Resource = Capability,
    KeyName = "capabilityName",
    SegmentName = "capabilities",
    NamePattern = "^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$"
  >;
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
    Parameters = {
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
