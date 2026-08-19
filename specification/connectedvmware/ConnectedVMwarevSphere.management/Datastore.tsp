import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the datastore.")
model Datastore is TrackedResource<DatastoreProperties> {
  @doc("Name of the datastore.")
  @path
  @key("datastoreName")
  @segment("datastores")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Datastores {
  @doc("Implements datastore GET method.")
  get is ArmResourceRead<Datastore>;
  @doc("Create Or Update datastore.")
  create is ArmResourceCreateOrUpdateAsync<Datastore>;
  @doc("API to update certain properties of the datastore resource.")
  update is ArmTagsPatchSync<Datastore>;
  @doc("Implements datastore DELETE method.")
  delete is ArmResourceDeleteAsync<
    Datastore,
    {
      ...BaseParameters<Datastore>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of datastores in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Datastore>;
  @doc("List of datastores in a subscription.")
  list is ArmListBySubscription<Datastore>;
}
