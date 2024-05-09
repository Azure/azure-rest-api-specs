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
  @pattern("^[a-zA-Z0-9-]{3,90}$")
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
  list is ArmResourceListByParent<ApiDefinition>;
  @doc("Imports the API specification.")
  importSpecification is ArmResourceActionAsync<
    ApiDefinition,
    ApiSpecImportRequest,
    ApiImportSuccess
  >;
  @doc("Exports the API specification.")
  exportSpecification is ArmResourceActionAsync<
    ApiDefinition,
    void,
    ApiSpecExportResult
  >;
}

/** The API specification was successfully imported. */
model ApiImportSuccess {
  /** The response status code */
  @statusCode code: 200;
}
