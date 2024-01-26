import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;
/**
 * Rollout details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ProviderRegistration)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CustomRolloutProperties)
model CustomRollout extends ProxyResourceBase {
  /**
   * The rollout name.
   */
  @path
  @key("rolloutName")
  @segment("customRollouts")
  @visibility("read")
  name: string;

  /**
   * Properties of the rollout.
   */
  @extension("x-ms-client-flatten", true)
  properties: CustomRolloutProperties;
}

@armResourceOperations
interface CustomRollouts {
  /**
   * Gets the custom rollout details.
   */
  get is ArmResourceRead<CustomRollout>;

  /**
   * Creates or updates the rollout details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<CustomRollout>;

  /**
   * Gets the list of the custom rollouts for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CustomRollouts_ListByProviderRegistration")
  listByProviderRegistration is ArmResourceListByParent<CustomRollout>;
}

@@projectedName(CustomRollouts.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(CustomRollouts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(CustomRollouts.createOrUpdate::parameters.resource,
  "The custom rollout properties supplied to the CreateOrUpdate operation."
);
