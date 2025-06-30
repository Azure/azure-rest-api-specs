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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ServiceRunner extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("servicerunners")
  name: string;

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
