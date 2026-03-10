import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/configDefModels/configDefModels.tsp";

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
@doc("A connector configDef resource Azure")
model ConfigDef is TrackedResource<Models.ConfigDef.ConfigurationDefRequest> {
  @doc("The default connector configDef resource")
  @path
  @key("configDef")
  @segment("configDef")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;
}

@armResourceOperations
interface ConfigDefOperations {
  @doc("create one configDef task")
  getConfigurationDef is ArmResourceActionAsync<
    ConfigDef,
    Models.ConfigDef.ConfigurationDefRequest,
    Models.ConfigDef.ConfigurationDefResult
  >;
}
