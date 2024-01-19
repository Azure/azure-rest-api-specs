import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A cloud link resource")
@parentResource(PrivateCloud)
model CloudLink is ProxyResource<CloudLinkProperties> {
  @doc("Name of the cloud link resource")
  @path
  @key("cloudLinkName")
  @segment("cloudLinks")
  name: string;
}

@armResourceOperations
interface CloudLinks {
  @doc("Get an cloud link by name in a private cloud")
  get is ArmResourceRead<CloudLink>;

  @doc("Create or update a cloud link in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudLink>;

  @doc("Delete a cloud link in a private cloud")
  delete is ArmResourceDeleteAsync<CloudLink>;

  @doc("List cloud link in a private cloud")
  list is ArmResourceListByParent<CloudLink>;
}

@@projectedName(CloudLinks.createOrUpdate::parameters.resource,
  "json",
  "cloudLink"
);
@@extension(CloudLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cloudLink"
);
@@doc(CloudLinks.createOrUpdate::parameters.resource,
  "A cloud link in the private cloud"
);
