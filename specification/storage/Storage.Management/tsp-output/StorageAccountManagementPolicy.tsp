import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Storage;
@doc("The Get Storage Account ManagementPolicies operation response.")
@parentResource(StorageAccount)
@singleton("default")
model StorageAccountManagementPolicy
  is ProxyResource<ManagementPolicyProperties> {
  @key("managementPolicyName")
  @segment("managementPolicies")
  name: string;
}

@armResourceOperations
interface StorageAccountManagementPolicies {
  @doc("Gets the managementpolicy associated with the specified storage account.")
  get is ArmResourceRead<StorageAccountManagementPolicy>;
  @doc("Sets the managementpolicy to the specified storage account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageAccountManagementPolicy>;
  @doc("Deletes the managementpolicy associated with the specified storage account.")
  delete is ArmResourceDeleteSync<StorageAccountManagementPolicy>;
}
