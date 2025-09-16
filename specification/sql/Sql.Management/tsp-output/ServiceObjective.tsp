import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Represents a database service objective.
 */
@parentResource(Server)
model ServiceObjective is ProxyResource<ServiceObjectiveProperties> {
  /**
   * The name of the service objective to retrieve.
   */
  @path
  @key("serviceObjectiveName")
  @segment("serviceObjectives")
  name: string;
}

@armResourceOperations
interface ServiceObjectives {
  /**
   * Gets a database service objective.
   */
  get is ArmResourceRead<ServiceObjective>;

  /**
   * Returns database service objectives.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceObjectives_ListByServer")
  listByServer is ArmResourceListByParent<ServiceObjective>;
}
