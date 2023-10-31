import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApiVersion.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;
@doc("API definition entity.")
@parentResource(ApiVersion)
model ApiDefinition is ProxyResource<ApiDefinitionProperties> {
  @doc("The name of the API definition.")
  @maxLength(90)
  @minLength(1)
  @path
  @key("definitionName")
  @segment("definitions")
  name: string;
}

@armResourceOperations
interface ApiDefinitions {
  @doc("Returns details of the API definition.")
  get is ArmResourceRead<ApiDefinition>;
  @doc("Checks if specified API definition exists.")
  @head
  head(
    ...ResourceInstanceParameters<ApiDefinition, BaseParameters<ApiDefinition>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing API definition.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApiDefinition>;
  @doc("Deletes specified API definition.")
  delete is ArmResourceDeleteSync<ApiDefinition>;
  @doc("Returns a collection of API definitions.")
  list is ArmResourceListByParent<
    ApiDefinition,
    {
      ...BaseParameters<ApiDefinition>;

      @doc("OData filter parameter.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Imports the API specification.")
  importSpecification is ArmResourceActionSync<
    ApiDefinition,
    ApiSpecImportRequest,
    {}
  >;
  @doc("Exports the API specification.")
  exportSpecification is ArmResourceActionSync<
    ApiDefinition,
    {},
    ApiSpecExportResult
  >;
}
