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
@doc("Site resource.")
model Site is TrackedResource<SitePropertiesFormat> {
  @doc("The name of the network service site.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  name: string;
}

@armResourceOperations
interface Sites {
  @doc("Gets information about the specified network site.")
  get is ArmResourceRead<Site>;

  @doc("Creates or updates a network site.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Site,
    BaseParameters<Site>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a site update tags.")
  updateTags is ArmCustomPatchSync<Site, TagsObject>;

  @doc("Deletes the specified network site.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Site,
    BaseParameters<Site>,
    ArmLroLocationHeader
  >;

  @doc("Lists all sites in the network service.")
  listByResourceGroup is ArmResourceListByParent<Site>;

  @doc("Lists all sites in the network service in a subscription.")
  listBySubscription is ArmListBySubscription<Site>;
}

@@projectedName(Sites.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Sites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network site operation."
);
@@projectedName(Sites.updateTags::parameters.properties, "json", "parameters");
@@extension(Sites.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
