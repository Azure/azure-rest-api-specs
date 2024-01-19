import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
@doc("An Account Filter.")
@parentResource(MediaService)
model AccountFilter is ProxyResource<MediaFilterProperties> {
  @doc("The Account Filter name")
  @path
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

@@projectedName(AccountFilters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AccountFilters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AccountFilters.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(AccountFilters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(AccountFilters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AccountFilters.update::parameters.properties, "The request parameters");
