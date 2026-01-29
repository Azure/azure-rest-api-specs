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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosCustomPolicy extends Resource {
  properties?: DdosCustomPolicyPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ddosCustomPolicyName")
  @segment("ddosCustomPolicies")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface DdosCustomPolicies {
  /**
   * Gets information about the specified DDoS custom policy.
   */
  get is ArmResourceRead<DdosCustomPolicy, Error = CloudError>;

  /**
   * Creates or updates a DDoS custom policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DdosCustomPolicy,
    Error = CloudError
  >;

  /**
   * Update a DDoS custom policy tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    DdosCustomPolicy,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified DDoS custom policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DdosCustomPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;
}

@@doc(DdosCustomPolicy.name, "The name of the DDoS custom policy.");
@@doc(DdosCustomPolicy.properties, "Properties of the DDoS custom policy.");
@@doc(DdosCustomPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update operation."
);
@@doc(DdosCustomPolicies.updateTags::parameters.properties,
  "Parameters supplied to update DDoS custom policy resource tags."
);
