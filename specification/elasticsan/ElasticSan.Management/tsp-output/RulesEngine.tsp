import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
@doc("A rules engine configuration containing a list of rules that will run to modify the runtime behavior of the request and response.")
@parentResource(FrontDoor)
model RulesEngine is ProxyResource<RulesEngineProperties> {
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
interface RulesEngines {
  @doc("Gets a Rules Engine Configuration with the specified name within the specified Front Door.")
  get is ArmResourceRead<RulesEngine>;

  @doc("Creates a new Rules Engine Configuration with the specified name within the specified Front Door.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    RulesEngine,
    BaseParameters<RulesEngine>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes an existing Rules Engine Configuration with the specified parameters.")
  delete is ArmResourceDeleteWithoutOkAsync<
    RulesEngine,
    BaseParameters<RulesEngine>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the Rules Engine Configurations within a Front Door.")
  listByFrontDoor is ArmResourceListByParent<RulesEngine>;
}

@@projectedName(RulesEngines.createOrUpdate::parameters.resource,
  "json",
  "rulesEngineParameters"
);
@@extension(RulesEngines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "rulesEngineParameters"
);
@@doc(RulesEngines.createOrUpdate::parameters.resource,
  "Rules Engine Configuration properties needed to create a new Rules Engine Configuration."
);
