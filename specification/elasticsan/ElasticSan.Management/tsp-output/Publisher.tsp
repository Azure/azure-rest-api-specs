import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
@doc("publisher resource.")
model Publisher is TrackedResource<PublisherPropertiesFormat> {
  @doc("The name of the publisher.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("publisherName")
  @segment("publishers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Publishers {
  @doc("Gets information about the specified publisher.")
  get is ArmResourceRead<Publisher>;

  @doc("Creates or updates a publisher.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Publisher,
    BaseParameters<Publisher>,
    ArmAsyncOperationHeader
  >;

  @doc("Update a publisher resource.")
  update is ArmCustomPatchSync<Publisher, TagsObject>;

  @doc("Deletes the specified publisher.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Publisher,
    BaseParameters<Publisher>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the publishers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Publisher>;

  @doc("Lists all the publishers in a subscription.")
  listBySubscription is ArmListBySubscription<Publisher>;
}

@@projectedName(Publishers.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Publishers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Publishers.createOrUpdate::parameters.resource,
  "Parameters supplied to the create publisher operation."
);
@@projectedName(Publishers.update::parameters.properties, "json", "parameters");
@@extension(Publishers.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Publishers.update::parameters.properties,
  "Parameters supplied to the create publisher operation."
);
