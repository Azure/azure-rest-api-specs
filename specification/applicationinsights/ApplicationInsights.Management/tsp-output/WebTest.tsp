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
/**
 * An Application Insights WebTest definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WebTestProperties)
model WebTest extends TrackedResourceBase {
  /**
   * The name of the Application Insights WebTest resource.
   */
  @path
  @key("webTestName")
  @segment("webtests")
  @visibility("read")
  name: string;

  /**
   * The kind of WebTest that this web test watches. Choices are ping, multistep and standard.
   */
  kind?: WebTestKind;

  /**
   * Metadata describing a web test for an Azure resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebTestProperties;
}

@armResourceOperations
interface WebTests {
  /**
   * Get a specific Application Insights web test definition.
   */
  get is ArmResourceRead<WebTest>;

  /**
   * Creates or updates an Application Insights web test definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<WebTest>;

  /**
   * Updates the tags associated with an Application Insights web test.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<WebTest, TagsResource>;

  /**
   * Deletes an Application Insights web test.
   */
  delete is ArmResourceDeleteSync<WebTest>;

  /**
   * Get all Application Insights web tests defined for the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebTests_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WebTest>;

  /**
   * Get all Application Insights web test definitions for the specified subscription.
   */
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
