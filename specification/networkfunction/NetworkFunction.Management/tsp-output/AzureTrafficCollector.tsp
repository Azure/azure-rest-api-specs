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

namespace Microsoft.NetworkFunction;
/**
 * Azure Traffic Collector resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model AzureTrafficCollector extends TrackedResource {
  /**
   * Azure Traffic Collector name
   */
  @path
  @key("azureTrafficCollectorName")
  @segment("azureTrafficCollectors")
  @visibility("read")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Properties of the Azure Traffic Collector.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureTrafficCollectorPropertiesFormat;
}

@armResourceOperations
interface AzureTrafficCollectors {
  /**
   * Gets the specified Azure Traffic Collector in a specified resource group
   */
  get is ArmResourceRead<AzureTrafficCollector>;

  /**
   * Creates or updates a Azure Traffic Collector resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureTrafficCollector,
    BaseParameters<AzureTrafficCollector>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the specified Azure Traffic Collector tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<AzureTrafficCollector, TagsObject>;

  /**
   * Deletes a specified Azure Traffic Collector resource.
   */
  delete is ArmResourceDeleteAsync<
    AzureTrafficCollector,
    BaseParameters<AzureTrafficCollector>,
    ArmLroLocationHeader
  >;

  /**
   * Return list of Azure Traffic Collectors in a Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureTrafficCollectorsByResourceGroup_List")
  list is ArmResourceListByParent<AzureTrafficCollector>;
}

@@projectedName(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Azure Traffic Collector."
);
@@projectedName(AzureTrafficCollectors.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(AzureTrafficCollectors.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AzureTrafficCollectors.updateTags::parameters.properties,
  "Parameters supplied to update Azure Traffic Collector tags."
);
