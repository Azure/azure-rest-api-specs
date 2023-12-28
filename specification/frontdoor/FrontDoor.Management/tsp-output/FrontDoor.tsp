import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.FrontDoor;
@doc("Front Door represents a collection of backend endpoints to route traffic to along with rules that specify how traffic is sent there.")
model FrontDoor is TrackedResource<FrontDoorProperties> {
  @doc("Name of the Front Door which is globally unique.")
  @maxLength(64)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$")
  @key("frontDoorName")
  @segment("frontDoors")
  name: string;
}

@armResourceOperations
interface FrontDoors {
  @doc("Gets a Front Door with the specified Front Door name under the specified subscription and resource group.")
  get is ArmResourceRead<FrontDoor>;
  @doc("Creates a new Front Door with a Front Door name under the specified subscription and resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FrontDoor>;
  @doc("Deletes an existing Front Door with the specified parameters.")
  delete is ArmResourceDeleteWithoutOkAsync<FrontDoor>;
  @doc("Lists all of the Front Doors within a resource group under a subscription.")
  listByResourceGroup is ArmResourceListByParent<FrontDoor>;
  @doc("Lists all of the Front Doors within an Azure subscription.")
  list is ArmListBySubscription<FrontDoor>;
  @doc("Validates the custom domain mapping to ensure it maps to the correct Front Door endpoint in DNS.")
  validateCustomDomain is ArmResourceActionSync<
    FrontDoor,
    ValidateCustomDomainInput,
    ValidateCustomDomainOutput
  >;
}

@armResourceOperations
interface Endpoints {
  @doc("Removes a content from Front Door.")
  purgeContent is ArmResourceActionAsync<FrontDoor, PurgeParameters, void>;
}
