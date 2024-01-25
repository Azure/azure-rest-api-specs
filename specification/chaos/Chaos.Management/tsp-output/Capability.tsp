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
/**
 * Model that represents a Capability resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Target)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CapabilityProperties)
model Capability extends ProxyResourceBase {
  /**
   * String that represents a Capability resource name.
   */
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityName")
  @segment("capabilities")
  @visibility("read")
  name: string;

  /**
   * The properties of a capability resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CapabilityProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capabilities_List")
  list is ArmResourceListByParent<
    Capability,
    {
      ...BaseParameters<Capability>;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

@@projectedName(Capabilities.createOrUpdate::parameters.resource,
  "json",
  "capability"
);
@@extension(Capabilities.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "capability"
);
@@doc(Capabilities.createOrUpdate::parameters.resource,
  "Capability resource to be created or updated."
);
