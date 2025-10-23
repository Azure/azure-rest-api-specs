import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Cosmos DB location get result
 */
@subscriptionResource
model LocationGetResult
  is Azure.ResourceManager.ProxyResource<LocationProperties> {
  ...ResourceNameParameter<
    Resource = LocationGetResult,
    KeyName = "location",
    SegmentName = "locations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LocationGetResults {
  /**
   * Get the properties of an existing Cosmos DB location
   */
  get is ArmResourceRead<
    LocationGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * List Cosmos DB locations and their properties
   */
  list is ArmResourceListByParent<
    LocationGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<LocationListResult>,
    Error = CloudError
  >;
}

@@doc(LocationGetResult.name,
  "Cosmos DB region, with spaces between words and each word capitalized."
);
@@doc(LocationGetResult.properties, "Cosmos DB location metadata");
