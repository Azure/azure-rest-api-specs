import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeStoreAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataLakeStore;
@doc("Data Lake Store trusted identity provider information.")
@parentResource(DataLakeStoreAccount)
model TrustedIdProvider is ProxyResource<TrustedIdProviderProperties> {
  @doc("The name of the trusted identity provider to retrieve.")
  @path
  @key("trustedIdProviderName")
  @segment("trustedIdProviders")
  name: string;
}

@armResourceOperations
interface TrustedIdProviders {
  @doc("Gets the specified Data Lake Store trusted identity provider.")
  get is ArmResourceRead<TrustedIdProvider>;
  @doc("Creates or updates the specified trusted identity provider. During update, the trusted identity provider with the specified name will be replaced with this new provider")
  createOrUpdate is ArmResourceCreateOrReplaceSync<TrustedIdProvider>;
  @doc("Updates the specified trusted identity provider.")
  update is ArmResourcePatchSync<
    TrustedIdProvider,
    TrustedIdProviderProperties
  >;
  @doc("Deletes the specified trusted identity provider from the specified Data Lake Store account")
  delete is ArmResourceDeleteSync<TrustedIdProvider>;
  @doc("Lists the Data Lake Store trusted identity providers within the specified Data Lake Store account.")
  listByAccount is ArmResourceListByParent<TrustedIdProvider>;
}
