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
 * The error summary resource definition.
 */
@parentResource(SpringbootsitesModel)
model ErrorSummary is ProxyResource<ErrorSummariesProperties> {
  /**
   * The name of error summary
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z][A-Za-z0-9]*$")
  @path
  @key("errorSummaryName")
  @segment("errorSummaries")
  name: string;
}

@armResourceOperations
interface ErrorSummaries {
  /**
   * Gets the ErrorSummaries resource.
   */
  get is ArmResourceRead<ErrorSummary>;

  /**
   * Lists the ErrorSummaries resource in springbootsites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ErrorSummaries_ListBySite")
  listBySite is ArmResourceListByParent<ErrorSummary>;
}
