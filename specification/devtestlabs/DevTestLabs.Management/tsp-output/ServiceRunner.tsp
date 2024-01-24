import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
// FIXME: ServiceRunner has no properties property
/**
 * A container for a managed identity to execute DevTest lab services.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal({})
@includeInapplicableMetadataInPayload(false)
model ServiceRunner extends Resource {
  /**
   * The name of the service runner.
   */
  @path
  @key("name")
  @segment("servicerunners")
  name: string;

  /**
   * The identity of the resource.
   */
  identity?: IdentityProperties;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
}

@armResourceOperations
interface ServiceRunners {
  /**
   * Get service runner.
   */
  get is ArmResourceRead<ServiceRunner>;

  /**
   * Create or replace an existing service runner.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceRunner>;

  /**
   * Delete service runner.
   */
  delete is ArmResourceDeleteSync<ServiceRunner>;
}

@@projectedName(ServiceRunners.createOrUpdate::parameters.resource,
  "json",
  "serviceRunner"
);
@@extension(ServiceRunners.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "serviceRunner"
);
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
