import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureTrafficCollector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkFunction;
/**
 * Collector policy resource.
 */
@parentResource(AzureTrafficCollector)
model CollectorPolicy
  is Azure.ResourceManager.TrackedResource<CollectorPolicyPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = CollectorPolicy,
    KeyName = "collectorPolicyName",
    SegmentName = "collectorPolicies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface CollectorPolicies {
  /**
   * Gets the collector policy in a specified Traffic Collector
   */
  get is ArmResourceRead<CollectorPolicy>;

  /**
   * Creates or updates a Collector Policy resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CollectorPolicy>;

  /**
   * Updates the specified Collector Policy tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<CollectorPolicy, PatchModel = TagsObject>;

  /**
   * Deletes a specified Collector Policy resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    CollectorPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Return list of Collector policies in a Azure Traffic Collector
   */
  list is ArmResourceListByParent<CollectorPolicy>;
}

@@doc(CollectorPolicy.name, "Collector Policy Name");
@@doc(CollectorPolicy.properties, "Properties of the Collector Policy.");
@@doc(CollectorPolicies.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Collector Policy."
);
@@doc(CollectorPolicies.updateTags::parameters.properties,
  "Parameters supplied to update Collector Policy tags."
);
