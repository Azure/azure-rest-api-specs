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

@doc("Represents a platform update resource.")
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_03_01_preview)
model PlatformUpdate
  is Azure.ResourceManager.ProxyResource<PlatformUpdateProperties> {
  ...ResourceNameParameter<
    Resource = PlatformUpdate,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface PlatformUpdates {
  @doc("Get a platform update.")
  get is ArmResourceRead<PlatformUpdate>;

  @doc("List all platform updates.")
  list is ArmResourceListByParent<
    PlatformUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}
