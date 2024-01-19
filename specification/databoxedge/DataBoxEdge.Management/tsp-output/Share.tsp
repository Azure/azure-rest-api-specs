import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("Represents a share on the  Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeDevice)
model Share is ProxyResource<ShareProperties> {
  @doc("The share name.")
  @path
  @key("name")
  @segment("shares")
  name: string;
}

@armResourceOperations
interface Shares {
  @doc("Gets a share by name.")
  get is ArmResourceRead<Share>;

  @doc("Creates a new share or updates an existing share on the device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Share>;

  @doc("Deletes the share on the Data Box Edge/Data Box Gateway device.")
  delete is ArmResourceDeleteAsync<Share>;

  @doc("Lists all the shares in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Share>;

  @doc("Refreshes the share metadata with the data from the cloud.")
  refresh is ArmResourceActionAsync<Share, void, void>;
}

@@projectedName(Shares.createOrUpdate::parameters.resource, "json", "share");
@@extension(Shares.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "share"
);
@@doc(Shares.createOrUpdate::parameters.resource, "The share properties.");
