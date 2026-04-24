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
  is Azure.ResourceManager.ProxyResource<CollectorPolicyPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = CollectorPolicy,
    KeyName = "collectorPolicyName",
    SegmentName = "collectorPolicies",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface CollectorPolicies {
  /**
   * Gets the collector policy in a specified Traffic Collector
   */
  get is ArmResourceRead<CollectorPolicy, Error = CloudError>;

  /**
   * Creates or updates a Collector Policy resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CollectorPolicy,
    Error = CloudError
  >;

  /**
   * Updates the specified Collector Policy tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    CollectorPolicy,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a specified Collector Policy resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    CollectorPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Return list of Collector policies in a Azure Traffic Collector
   */
  list is ArmResourceListByParent<CollectorPolicy, Error = CloudError>;
}

@@doc(CollectorPolicy.name, "Collector Policy Name");
@@doc(CollectorPolicy.properties, "Properties of the Collector Policy.");
@@doc(CollectorPolicies.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Collector Policy."
);
@@Azure.ClientGenerator.Core.clientName(CollectorPolicies.updateTags::parameters.properties,
  "parameters"
);
