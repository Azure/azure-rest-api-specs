import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A Storage Account resource")
@armVirtualResource
model StorageAccount {
  @doc("The name of the storage account.")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  @key("storageAccountName")
  @segment("storageAccounts")
  storageAccountName: string;
}
