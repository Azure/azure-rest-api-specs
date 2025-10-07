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
interface ServiceRunnerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ServiceRunner,
        KeyName = "name",
        SegmentName = "servicerunners",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ServiceRunners {
  /**
   * Get service runner.
   */
  get is ServiceRunnerOps.Read<ServiceRunner>;

  /**
   * Create or replace an existing service runner.
   */
  createOrUpdate is ServiceRunnerOps.CreateOrUpdateSync<ServiceRunner>;

  /**
   * Delete service runner.
   */
  delete is ServiceRunnerOps.DeleteSync<ServiceRunner>;
}

@@doc(ServiceRunner.name, "The name of the service runner.");
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
