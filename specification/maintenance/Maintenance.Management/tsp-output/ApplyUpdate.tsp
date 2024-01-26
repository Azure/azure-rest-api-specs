import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maintenance;
/**
 * Apply Update request
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ApplyUpdateProperties)
model ApplyUpdate extends ProxyResourceBase {
  /**
   * applyUpdate Id
   */
  @path
  @key("applyUpdateName")
  @segment("applyUpdates")
  @visibility("read")
  name: string;

  /**
   * Properties of the apply update
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApplyUpdateProperties;
}

@armResourceOperations
interface ApplyUpdates {
  /**
   * Track maintenance updates to resource
   */
  get is ArmResourceRead<ApplyUpdate>;

  /**
   * Apply maintenance updates to resource
   */
  createOrUpdateOrCancel is ArmResourceCreateOrReplaceSync<ApplyUpdate>;

  /**
   * Get Configuration records within a subscription
   */
  list is ArmListBySubscription<ApplyUpdate>;
}

@@projectedName(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "json",
  "applyUpdate"
);
@@extension(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "x-ms-client-name",
  "applyUpdate"
);
@@doc(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "The ApplyUpdate"
);
