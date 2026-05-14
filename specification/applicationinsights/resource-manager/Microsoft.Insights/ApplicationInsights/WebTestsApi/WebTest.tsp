import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using ApplicationInsightsCommonTypes;

namespace WebTestsApi;
/**
 * An Application Insights WebTest definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model WebTest extends WebtestsResource {
  @visibility(Lifecycle.Read)
  @path
  @key("webTestName")
  @segment("webtests")
  name: string;

  /**
   * The kind of WebTest that this web test watches. Choices are ping, multistep and standard.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: WebTestKind = WebTestKind.ping;

  /**
   * Properties that define an Application Insights web test.
   */
  properties?: WebTestProperties;
}

@armResourceOperations(#{ omitTags: true })
interface WebTests {
  /**
   * Get a specific Application Insights web test definition.
   */
  get is ArmResourceRead<WebTest, Error = never>;

  /**
   * Creates or updates an Application Insights web test definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WebTest,
    Response = ArmResourceUpdatedResponse<WebTest>,
    Error = never
  >;

  /**
   * Updates the tags associated with an Application Insights web test.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    WebTest,
    PatchModel = TagsResource,
    Error = never
  >;

  /**
   * Deletes an Application Insights web test.
   */
  delete is ArmResourceDeleteSync<WebTest, Error = never>;

  /**
   * Get all Application Insights web tests defined for the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    WebTest,
    Response = webTestListResult,
    Error = never
  >;

  /**
   * Get all Application Insights web test definitions for the specified subscription.
   */
  list is ArmListBySubscription<
    WebTest,
    Response = webTestListResult,
    Error = never
  >;
}

@@doc(WebTest.name, "The name of the Application Insights WebTest resource.");
@@doc(WebTest.properties,
  "Metadata describing a web test for an Azure resource."
);
@@doc(WebTests.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update an Application Insights web test definition."
);
@@doc(WebTests.updateTags::parameters.properties,
  "Updated tag information to associate with the web test resource."
);
