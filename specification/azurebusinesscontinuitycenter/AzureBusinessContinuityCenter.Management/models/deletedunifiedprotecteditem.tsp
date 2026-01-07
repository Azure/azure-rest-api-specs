import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./unifiedprotecteditem.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureBusinessContinuity;
@doc("A DeletedUnifiedProtectedItem represents a protected item by backup or replication solution of deleted resource.")
model DeletedUnifiedProtectedItemResource
  is ProxyResource<UnifiedProtectedItemProperties> {
  @key("deletedUnifiedProtectedItemsName")
  @segment("deletedUnifiedProtectedItems")
  @path
  @visibility(Lifecycle.Read)
  @doc("The name of the deleted unified protected item.")
  @pattern("^[a-zA-Z0-9;/_]+$")
  name: string;
}
