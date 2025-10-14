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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Locations_Get")
  get is ArmResourceRead<
    LocationGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List Cosmos DB locations and their properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Locations_List")
  list is ArmResourceListByParent<
    LocationGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<LocationListResult>
  >;
}

@@doc(LocationGetResult.name,
  "Cosmos DB region, with spaces between words and each word capitalized."
);
@@doc(LocationGetResult.properties, "Cosmos DB location metadata");
