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
@parentResource(Lab)
model ServiceRunner is TrackedResource<{}> {
  /**
   * The name of the service runner.
   */
  @path
  @key("name")
  @segment("servicerunners")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
