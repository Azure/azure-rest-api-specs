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
@doc("Azure Traffic Collector resource.")
model AzureTrafficCollector
  is TrackedResource<AzureTrafficCollectorPropertiesFormat> {
  @doc("Azure Traffic Collector name")
  @path
  @key("azureTrafficCollectorName")
  @segment("azureTrafficCollectors")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface AzureTrafficCollectors {
  @doc("Gets the specified Azure Traffic Collector in a specified resource group")
  get is ArmResourceRead<AzureTrafficCollector>;

  @doc("Creates or updates a Azure Traffic Collector resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AzureTrafficCollector,
    BaseParameters<AzureTrafficCollector>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the specified Azure Traffic Collector tags.")
  updateTags is ArmCustomPatchSync<AzureTrafficCollector, TagsObject>;

  @doc("Deletes a specified Azure Traffic Collector resource.")
  delete is ArmResourceDeleteAsync<
    AzureTrafficCollector,
    BaseParameters<AzureTrafficCollector>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Return list of Azure Traffic Collectors in a Resource Group")
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
