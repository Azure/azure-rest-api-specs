import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.OpenAPI;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service({
  title: "Microsoft.MessagingConnectors management service",
})
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@singleton("default")
@parentResource(SubscriptionLocationResource)
@doc("A dataPreview resource Azure")
model DataPreview is TrackedResource<DataPreviewProperties> {
  @doc("The default data preview resource")
  @path
  @key("dataPreview")
  @segment("dataPreview")
  @visibility("read")
  @pattern("^default$")
  name: string;
}

@armResourceOperations
interface DataPreviewOperations {
  @doc("create one dataPreview task")
  preview is ArmResourceActionAsync<
    DataPreview,
    DataPreviewProperties,
    DataPreviewResults
  >;
}
