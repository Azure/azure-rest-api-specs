import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Represents a os image resource.")
@parentResource(SubscriptionLocationResource)
@removed(Versions.v2026_02_01)
model OsImage is Azure.ResourceManager.ProxyResource<OsImageProperties> {
  ...ResourceNameParameter<
    Resource = OsImage,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@removed(Versions.v2026_02_01)
interface OsImages {
  @doc("Get a os image.")
  get is ArmResourceRead<OsImage>;

  @doc("List all os images.")
  list is ArmResourceListAtScope<OsImage>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a os image resource.")
@removed(Versions.v2026_02_01)
model OsImageProperties {
  @doc("Represents validated solution recipe version of a os image.")
  validatedSolutionRecipeVersion?: string;

  @doc("Represents composed image version of a os image.")
  composedImageVersion?: string;

  @doc("Represents composed image iso download url of a os image.")
  composedImageIsoUrl?: string;

  @doc("Represents composed image iso hash of a os image.")
  composedImageIsoHash?: string;
}
