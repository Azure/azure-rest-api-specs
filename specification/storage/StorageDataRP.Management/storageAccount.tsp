import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.StorageDataRp;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A Storage Account resource")
model StorageAccount is TrackedResource<AccountProperties> {
  @doc("The name of the storage account")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("accountName")
  @segment("storageAccounts")
  @path
  name: string;
}

@doc("Storage Account Properties.")
model AccountProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface StorageAccounts
  extends TrackedResourceOperations<StorageAccount, AccountProperties> {
  @doc("Delete a Storage Account.")
  delete is ArmResourceDeleteSync<StorageAccount>;
}
