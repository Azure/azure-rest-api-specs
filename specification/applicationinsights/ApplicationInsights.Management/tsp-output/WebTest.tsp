import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApplicationInsights;
@doc("An Application Insights WebTest definition.")
model WebTest is TrackedResource<WebTestProperties> {
  @doc("The name of the Application Insights WebTest resource.")
  @key("webTestName")
  @segment("webtests")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface WebTests {
  @doc("Get a specific Application Insights web test definition.")
  get is ArmResourceRead<WebTest>;
  @doc("Creates or updates an Application Insights web test definition.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WebTest>;
  @doc("Updates the tags associated with an Application Insights web test.")
  updateTags is ArmCustomPatchSync<WebTest, TagsResource>;
  @doc("Deletes an Application Insights web test.")
  delete is ArmResourceDeleteSync<WebTest>;
  @doc("Get all Application Insights web tests defined for the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<WebTest>;
  @doc("Get all Application Insights web test definitions for the specified subscription.")
  list is ArmListBySubscription<WebTest>;
}
