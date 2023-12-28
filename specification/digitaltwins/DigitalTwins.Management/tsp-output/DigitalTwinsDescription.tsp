import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DigitalTwins;
@doc("The description of the DigitalTwins service.")
model DigitalTwinsDescription is TrackedResource<DigitalTwinsProperties> {
  @doc("The name of the DigitalTwinsInstance.")
  @maxLength(63)
  @minLength(3)
  @pattern("^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$")
  @key("resourceName")
  @segment("digitalTwinsInstances")
  name: string;
}

@armResourceOperations
interface DigitalTwins {
  @doc("Get DigitalTwinsInstances resource.")
  get is ArmResourceRead<DigitalTwinsDescription>;
  @doc("Create or update the metadata of a DigitalTwinsInstance. The usual pattern to modify a property is to retrieve the DigitalTwinsInstance and security metadata, and then combine them with the modified values in a new body to update the DigitalTwinsInstance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DigitalTwinsDescription>;
  @doc("Update metadata of DigitalTwinsInstance.")
  update is ArmCustomPatchAsync<
    DigitalTwinsDescription,
    DigitalTwinsPatchDescription
  >;
  @doc("Delete a DigitalTwinsInstance.")
  delete is ArmResourceDeleteAsync<DigitalTwinsDescription>;
  @doc("Get all the DigitalTwinsInstances in a resource group.")
  listByResourceGroup is ArmResourceListByParent<DigitalTwinsDescription>;
  @doc("Get all the DigitalTwinsInstances in a subscription.")
  list is ArmListBySubscription<DigitalTwinsDescription>;
}
