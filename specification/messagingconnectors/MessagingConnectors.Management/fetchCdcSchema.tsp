import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/fetchCdcSchemaModels/fetchCdcSchemaModel.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.OpenAPI;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Microsoft.MessagingConnectors management service" })
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@singleton("default")
@parentResource(SubscriptionLocationResource)
@doc("A GetSchema resource Azure")
model SchemaResource is TrackedResource<SchemaRequestProperties> {
  @doc("The default Schema resource")
  @path
  @key("schema")
  @segment("schema")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;
}

@armResourceOperations
interface SchemaOperations {
  @doc("fetch Schema task")
  fetch is ArmResourceActionAsync<
    SchemaResource,
    SchemaRequestProperties,
    SchemaResult
  >;
}
