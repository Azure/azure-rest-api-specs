import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A DDoS custom policy in a resource group.
 */
model DdosCustomPolicy
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DdosCustomPolicyPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = DdosCustomPolicy,
    KeyName = "ddosCustomPolicyName",
    SegmentName = "ddosCustomPolicies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface DdosCustomPolicies {
  /**
   * Gets information about the specified DDoS custom policy.
   */
  get is ArmResourceRead<DdosCustomPolicy, Error = CloudError>;

  /**
   * Creates or updates a DDoS custom policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DdosCustomPolicy, Error = CloudError>;

  /**
   * Update a DDoS custom policy tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<DdosCustomPolicy, PatchModel = TagsObject, Error = CloudError>;

  /**
   * Deletes the specified DDoS custom policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<DdosCustomPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;
}

@@doc(DdosCustomPolicy.name, "The name of the DDoS custom policy.");
@@doc(DdosCustomPolicy.properties, "Properties of the DDoS custom policy.");
@@doc(DdosCustomPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update operation."
);
@@doc(DdosCustomPolicies.updateTags::parameters.properties,
  "Parameters supplied to update DDoS custom policy resource tags."
);
