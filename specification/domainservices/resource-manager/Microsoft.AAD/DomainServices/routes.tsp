import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AAD;

@armResourceOperations(#{ omitTags: true })
interface OuContainerOperations {
  /**
   * Lists all the available OuContainer operations.
   */
  @get
  @route("/providers/Microsoft.Aad/operations")
  @doc("Lists all the available OuContainer operations.")
  @list
  @tag("OuContainer")
  list(...ApiVersionParameter): OperationEntityListResult | CloudError;
}
