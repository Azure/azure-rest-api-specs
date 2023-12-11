import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ProviderHub;

@subscriptionResource
model ProviderRegistration is ProxyResource<ProviderRegistrationProperties> {
  @doc("The name of the resource provider hosted within ProviderHub.")
  @path
  @key("providerNamespace")
  @segment("providerRegistrations")
  name: string;
}

@armResourceOperations
interface ProviderRegistrations {
  @doc("Gets the provider registration details.")
  get is ArmResourceRead<ProviderRegistration>;
  @doc("Creates or updates the provider registration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProviderRegistration>;
  @doc("Deletes a provider registration.")
  delete is ArmResourceDeleteSync<ProviderRegistration>;
  @doc("Gets the list of the provider registrations in the subscription.")
  list is ArmResourceListByParent<ProviderRegistration>;
  @doc("Generates the manifest for the given provider.")
  generateManifest is ArmResourceActionSync<
    ProviderRegistration,
    {},
    ResourceProviderManifest
  >;
  @doc("Checkin the manifest.")
  checkinManifest is ArmResourceActionSync<
    ProviderRegistration,
    CheckinManifestParams,
    CheckinManifestInfo
  >;
}
