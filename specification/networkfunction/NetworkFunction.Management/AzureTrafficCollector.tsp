import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkFunction;
/**
 * Azure Traffic Collector resource.
 */
model AzureTrafficCollector
  is Azure.ResourceManager.TrackedResource<AzureTrafficCollectorPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = AzureTrafficCollector,
    KeyName = "azureTrafficCollectorName",
    SegmentName = "azureTrafficCollectors",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface AzureTrafficCollectors {
  /**
   * Gets the specified Azure Traffic Collector in a specified resource group
   */
  get is ArmResourceRead<AzureTrafficCollector, Error = CloudError>;

  /**
   * Creates or updates a Azure Traffic Collector resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureTrafficCollector,
    Error = CloudError
  >;

  /**
   * Updates the specified Azure Traffic Collector tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    AzureTrafficCollector,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a specified Azure Traffic Collector resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureTrafficCollector,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Return list of Azure Traffic Collectors in a Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureTrafficCollectorsByResourceGroup_List")
  list is ArmResourceListByParent<AzureTrafficCollector, Error = CloudError>;

  /**
   * Return list of Azure Traffic Collectors in a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureTrafficCollectorsBySubscription_List")
  azureTrafficCollectorsBySubscriptionList is ArmListBySubscription<
    AzureTrafficCollector,
    Error = CloudError
  >;
}

@@doc(AzureTrafficCollector.name, "Azure Traffic Collector name");
@@doc(AzureTrafficCollector.properties,
  "Properties of the Azure Traffic Collector."
);
@@doc(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Azure Traffic Collector."
);
@@doc(AzureTrafficCollectors.updateTags::parameters.properties,
  "Parameters supplied to update Azure Traffic Collector tags."
);
