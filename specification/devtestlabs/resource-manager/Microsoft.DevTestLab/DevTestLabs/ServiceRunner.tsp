import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A container for a managed identity to execute DevTest lab services.
 */
@parentResource(Lab)
model ServiceRunner is Azure.ResourceManager.ProxyResource<never, false> {
  ...ResourceNameParameter<
    Resource = ServiceRunner,
    KeyName = "serviceRunnerName",
    SegmentName = "servicerunners",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
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

@@doc(ServiceRunner.name, "The name of the service runner.");
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
