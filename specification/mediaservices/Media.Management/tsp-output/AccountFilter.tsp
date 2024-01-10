import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Media;
@doc("An Account Filter.")
@parentResource(MediaService)
model AccountFilter is ProxyResource<MediaFilterProperties> {
  @doc("The Account Filter name")
  @key("filterName")
  @segment("accountFilters")
  name: string;
}

@armResourceOperations
interface AccountFilters {
  @doc("Get the details of an Account Filter in the Media Services account.")
  get is ArmResourceRead<AccountFilter>;

  @doc("Creates or updates an Account Filter in the Media Services account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AccountFilter>;

  @doc("Updates an existing Account Filter in the Media Services account.")
  update is ArmCustomPatchSync<AccountFilter, AccountFilter>;

  @doc("Deletes an Account Filter in the Media Services account.")
  delete is ArmResourceDeleteSync<AccountFilter>;

  @doc("List Account Filters in the Media Services account.")
  list is ArmResourceListByParent<AccountFilter>;
}
