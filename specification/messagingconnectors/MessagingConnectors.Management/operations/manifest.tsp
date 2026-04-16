import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/manifestModels/manifestModel.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Microsoft.MessagingConnectors management service" })
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@singleton("default")
@parentResource(SubscriptionLocationResource)
@doc("A connector manifest resource.")
model ManifestResource is TrackedResource<Models.Manifest.ManifestProperties> {
  @doc("The default manifest resource.")
  @path
  @key("manifest")
  @segment("manifest")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;
}

@armResourceOperations
interface ManifestOperations {
  @doc("Get the connector manifest information.")
  getConnectorManifest is ArmResourceActionAsync<
    ManifestResource,
    Models.Manifest.GetConnectorManifestRequest,
    Models.Manifest.GetConnectorManifestResult
  >;

  @doc("Get the custom connector configuration definition.")
  getCustomConnectorConfigurationDef is ArmResourceActionAsync<
    ManifestResource,
    Models.Manifest.GetCustomConnectorConfigurationDefRequest,
    Models.Manifest.GetCustomConnectorConfigurationDefResult
  >;
}
