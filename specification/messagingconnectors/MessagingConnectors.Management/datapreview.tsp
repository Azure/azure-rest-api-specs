import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.MessagingConnectors;

@doc("A DataPreview resource Azure")
@subscriptionResource
model DataPreviewInstance is ProxyResource<DataPreviewProperties> {
  @doc("Name of the DataPreview resource.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("name")
  @segment("dataPreview")
  name: string;
}

@armResourceOperations(DataPreviewInstance)
interface DataPreviewOperations {
  @doc("Start one DataPreview task")
  startPreview is ArmResourceActionSync<
    DataPreviewInstance,
    DataPreviewProperties,
    void
  >;

  @doc("Get the result of DataPreview")
  getResults is ArmResourceActionSync<
    DataPreviewInstance,
    void,
    DataPreviewResults
  >;
}
