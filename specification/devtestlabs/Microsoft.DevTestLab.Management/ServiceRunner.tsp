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
// FIXME: ServiceRunner has no properties property
/**
 * A container for a managed identity to execute DevTest lab services.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@parentResource(Lab)
model ServiceRunner is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ServiceRunner,
    SegmentName = "servicerunners",
    NamePattern = ""
  >;

  /**
   * The location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  location?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Required to avoid SDK breaking change."
  tags?: Record<string>;

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
@@doc(ServiceRunner.location, "The location of the resource.");
@@doc(ServiceRunner.tags, "The tags of the resource.");
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
