import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * SIM policy resource.
 */
@parentResource(MobileNetwork)
model SimPolicy
  is Azure.ResourceManager.TrackedResource<SimPolicyPropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = SimPolicy,
    KeyName = "simPolicyName",
    SegmentName = "simPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SimPolicy>;

  /**
   * Updates SIM policy tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<SimPolicy, PatchModel = TagsObject>;

  /**
   * Deletes the specified SIM policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SimPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the SIM policies in a mobile network.
   */
  listByMobileNetwork is ArmResourceListByParent<SimPolicy>;
}

@@maxLength(SimPolicy.name, 64);
@@doc(SimPolicy.name, "The name of the SIM policy.");
@@doc(SimPolicy.properties, "SIM policy Properties.");
@@doc(SimPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM policy operation."
);
@@doc(SimPolicies.updateTags::parameters.properties,
  "Parameters supplied to update SIM policy tags."
);
