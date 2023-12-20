import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Define the datastore.")
model VMwareDatastore is TrackedResource<DatastoreProperties> {
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
interface VMwareDatastores {
  @doc("Implements datastore GET method.")
  get is ArmResourceRead<VMwareDatastore>;
  @doc("Create Or Update datastore.")
  create is ArmResourceCreateOrUpdateAsync<VMwareDatastore>;
  @doc("API to update certain properties of the datastore resource.")
  update is ArmTagsPatchSync<VMwareDatastore>;
  @doc("Implements datastore DELETE method.")
  delete is ArmResourceDeleteAsync<
    VMwareDatastore,
    {
      ...BaseParameters<VMwareDatastore>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of datastores in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMwareDatastore>;
  @doc("List of datastores in a subscription.")
  list is ArmListBySubscription<VMwareDatastore>;
}
