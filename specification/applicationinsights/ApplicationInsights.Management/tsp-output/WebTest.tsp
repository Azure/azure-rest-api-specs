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

namespace Microsoft.Insights;
@doc("An Application Insights WebTest definition.")
model WebTest is TrackedResource<WebTestProperties> {
  @doc("The name of the Application Insights WebTest resource.")
  @path
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

@@projectedName(WebTests.createOrUpdate::parameters.resource,
  "json",
  "WebTestDefinition"
);
@@extension(WebTests.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "WebTestDefinition"
);
@@doc(WebTests.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update an Application Insights web test definition."
);
@@projectedName(WebTests.updateTags::parameters.properties,
  "json",
  "WebTestTags"
);
@@extension(WebTests.updateTags::parameters.properties,
  "x-ms-client-name",
  "WebTestTags"
);
@@doc(WebTests.updateTags::parameters.properties,
  "Updated tag information to associate with the web test resource."
);
