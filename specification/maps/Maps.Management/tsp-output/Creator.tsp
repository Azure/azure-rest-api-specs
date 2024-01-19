import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
@doc("An Azure resource which represents Maps Creator product and provides ability to manage private location data.")
@parentResource(MapsAccount)
model Creator is TrackedResource<CreatorProperties> {
  @doc("The name of the Maps Creator instance.")
  @path
  @key("creatorName")
  @segment("creators")
  name: string;
}

@armResourceOperations
interface Creators {
  @doc("Get a Maps Creator resource.")
  get is ArmResourceRead<Creator>;

  @doc("Create or update a Maps Creator resource. Creator resource will manage Azure resources required to populate a custom set of mapping data. It requires an account to exist before it can be created.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Creator>;

  @doc("Updates the Maps Creator resource. Only a subset of the parameters may be updated after creation, such as Tags.")
  update is ArmCustomPatchSync<Creator, CreatorUpdateParameters>;

  @doc("Delete a Maps Creator resource.")
  delete is ArmResourceDeleteSync<Creator>;

  @doc("Get all Creator instances for an Azure Maps Account")
  listByAccount is ArmResourceListByParent<Creator>;
}

@@projectedName(Creators.createOrUpdate::parameters.resource,
  "json",
  "CreatorResource"
);
@@extension(Creators.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "CreatorResource"
);
@@doc(Creators.createOrUpdate::parameters.resource,
  "The new or updated parameters for the Creator resource."
);
@@projectedName(Creators.update::parameters.properties,
  "json",
  "CreatorUpdateParameters"
);
@@extension(Creators.update::parameters.properties,
  "x-ms-client-name",
  "CreatorUpdateParameters"
);
@@doc(Creators.update::parameters.properties,
  "The update parameters for Maps Creator."
);
