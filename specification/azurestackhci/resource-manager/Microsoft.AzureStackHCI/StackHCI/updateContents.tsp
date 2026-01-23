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

@doc("Represents a update content.")
@parentResource(SubscriptionLocationResource)
@removed(Versions.v2026_02_01)
model UpdateContent
  is Azure.ResourceManager.ProxyResource<UpdateContentProperties> {
  ...ResourceNameParameter<
    Resource = UpdateContent,
    NamePattern = "^[a-zA-Z0-9-.]{3,50}$"
  >;
}

@armResourceOperations
@removed(Versions.v2026_02_01)
interface UpdateContents {
  @doc("Gets content for an update.")
  get is ArmResourceRead<UpdateContent>;

  @doc("List all update contents.")
  list is ArmResourceListByParent<
    UpdateContent,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Represents properties of a update content resource.")
@removed(Versions.v2026_02_01)
model UpdateContentProperties {
  @doc("Represents the payloads of a update content resource.")
  @Azure.ResourceManager.identifiers(#[])
  updatePayloads: Array<ContentPayload>;
}

@doc("Represents details of a specific update content payload.")
@removed(Versions.v2026_02_01)
model ContentPayload {
  @doc("Represents url of a update payload.")
  url?: string;

  @doc("Represents hash of a update payload.")
  hash?: string;

  @doc("Represents hash algorithm of a update payload.")
  hashAlgorithm?: string;

  @doc("Represents identifier of a update payload.")
  identifier?: string;

  @doc("Represents size in bytes of a update payload.")
  packageSizeInBytes?: string;

  @doc("Represents the group of a update payload.")
  group?: string;

  @doc("Represents the file name of a update payload.")
  fileName?: string;
}
