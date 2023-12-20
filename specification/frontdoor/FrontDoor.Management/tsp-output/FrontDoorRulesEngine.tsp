import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.FrontDoor;
@doc("A rules engine configuration containing a list of rules that will run to modify the runtime behavior of the request and response.")
@parentResource(FrontDoor)
model FrontDoorRulesEngine is ProxyResource<RulesEngineProperties> {
  @doc("Name of the Rules Engine which is unique within the Front Door.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @path
  @key("rulesEngineName")
  @segment("rulesEngines")
  name: string;
}

@armResourceOperations
interface FrontDoorRulesEngines {
  @doc("Gets a Rules Engine Configuration with the specified name within the specified Front Door.")
  get is ArmResourceRead<FrontDoorRulesEngine>;
  @doc("Creates a new Rules Engine Configuration with the specified name within the specified Front Door.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FrontDoorRulesEngine>;
  @doc("Deletes an existing Rules Engine Configuration with the specified parameters.")
  delete is ArmResourceDeleteWithoutOkAsync<FrontDoorRulesEngine>;
  @doc("Lists all of the Rules Engine Configurations within a Front Door.")
  listByFrontDoor is ArmResourceListByParent<FrontDoorRulesEngine>;
}
