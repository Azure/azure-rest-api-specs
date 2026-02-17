import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Represents a os image resource.")
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model OsImage is Azure.ResourceManager.ProxyResource<OsImageProperties> {
  ...ResourceNameParameter<
    Resource = OsImage,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface OsImages {
  @doc("Get a os image.")
  get is ArmResourceRead<OsImage>;

  @doc("List all os images.")
  list is ArmResourceListAtScope<OsImage>;
}
