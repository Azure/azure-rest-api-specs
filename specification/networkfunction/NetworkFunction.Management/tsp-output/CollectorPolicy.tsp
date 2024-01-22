import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureTrafficCollector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkFunction;
/**
 * Collector policy resource.
 */
@parentResource(AzureTrafficCollector)
model CollectorPolicy is TrackedResource<CollectorPolicyPropertiesFormat> {
  /**
   * Collector Policy Name
   */
  @path
  @key("collectorPolicyName")
  @segment("collectorPolicies")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CollectorPolicy,
    BaseParameters<CollectorPolicy>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the specified Collector Policy tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<CollectorPolicy, TagsObject>;

  /**
   * Deletes a specified Collector Policy resource.
   */
  delete is ArmResourceDeleteAsync<
    CollectorPolicy,
    BaseParameters<CollectorPolicy>,
    ArmLroLocationHeader
  >;

  /**
   * Return list of Collector policies in a Azure Traffic Collector
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CollectorPolicies_List")
  list is ArmResourceListByParent<CollectorPolicy>;
}

@@projectedName(CollectorPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CollectorPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CollectorPolicies.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Collector Policy."
);
@@projectedName(CollectorPolicies.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(CollectorPolicies.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(CollectorPolicies.updateTags::parameters.properties,
  "Parameters supplied to update Collector Policy tags."
);
