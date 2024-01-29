import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
/**
 * The summary resource definition.
 */
@parentResource(SpringbootsitesModel)
model Summary is ProxyResource<SummariesProperties> {
  /**
   * The name of summary
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z][A-Za-z0-9]*$")
  @path
  @key("summaryName")
  @segment("summaries")
  name: string;
}

@armResourceOperations
interface Summaries {
  /**
   * Gets the Summaries resource.
   */
  @operationId("Summaries_Get")
  @summary("Implements Summaries GET method.")
  get is ArmResourceRead<Summary>;

  /**
   * Lists the Summaries resource in springbootsites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Summaries_ListBySite")
  @summary("Implements Summaries GET method.")
  listBySite is ArmResourceListByParent<Summary>;
}
