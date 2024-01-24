import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * SIM policy resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MobileNetwork)
@Azure.ResourceManager.Private.armResourceInternal(SimPolicyPropertiesFormat)
@includeInapplicableMetadataInPayload(false)
model SimPolicy extends TrackedResourceBase {
  /**
   * The name of the SIM policy.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simPolicyName")
  @segment("simPolicies")
  name: string;

  /**
   * SIM policy Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SimPolicyPropertiesFormat;
}

@armResourceOperations
interface SimPolicies {
  /**
   * Gets information about the specified SIM policy.
   */
  get is ArmResourceRead<SimPolicy>;

  /**
   * Creates or updates a SIM policy. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SimPolicy,
    BaseParameters<SimPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates SIM policy tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<SimPolicy, TagsObject>;

  /**
   * Deletes the specified SIM policy.
   */
  delete is ArmResourceDeleteAsync<
    SimPolicy,
    BaseParameters<SimPolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all the SIM policies in a mobile network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SimPolicies_ListByMobileNetwork")
  listByMobileNetwork is ArmResourceListByParent<SimPolicy>;
}

@@projectedName(SimPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SimPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM policy operation."
);
@@projectedName(SimPolicies.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(SimPolicies.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimPolicies.updateTags::parameters.properties,
  "Parameters supplied to update SIM policy tags."
);
