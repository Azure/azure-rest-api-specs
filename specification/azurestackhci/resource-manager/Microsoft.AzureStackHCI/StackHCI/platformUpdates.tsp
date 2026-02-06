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

@doc("Represents a platform update resource.")
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_02_15_preview)
model PlatformUpdate
  is Azure.ResourceManager.ProxyResource<PlatformUpdateProperties> {
  ...ResourceNameParameter<
    Resource = PlatformUpdate,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@added(Versions.v2026_02_15_preview)
interface PlatformUpdates {
  @doc("Get a platform update.")
  get is ArmResourceRead<PlatformUpdate>;

  @doc("List all platform updates.")
  list is ArmResourceListByParent<
    PlatformUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a platform update resource.")
@added(Versions.v2026_02_15_preview)
model PlatformUpdateProperties {
  @doc("Represents applicable platform updates.")
  @Azure.ResourceManager.identifiers(#[])
  platformUpdateDetails: Array<PlatformUpdateDetails>;
}

@doc("Represents details of a specific platform update.")
@added(Versions.v2026_02_15_preview)
model PlatformUpdateDetails {
  @doc("Represents validated solution recipe version of a platform update.")
  validatedSolutionRecipeVersion?: string;

  @doc("Represents version of a platform update.")
  platformVersion?: string;

  @doc("Represents the platform payloads of a platform update.")
  @Azure.ResourceManager.identifiers(#[])
  platformPayloads: Array<PlatformPayload>;
}

@doc("Represents details of a specific platform update payload.")
@added(Versions.v2026_02_15_preview)
model PlatformPayload {
  @doc("Represents url of a platform update payload.")
  payloadUrl?: string;

  @doc("Represents hash of a platform update payload.")
  payloadHash?: string;

  @doc("Represents size in bytes of a platform update payload.")
  payloadPackageSizeInBytes?: string;

  @doc("Represents identifier of a platform update payload.")
  payloadIdentifier?: string;
}
