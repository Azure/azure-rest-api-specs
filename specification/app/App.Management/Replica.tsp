import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Revision.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Revision Replica.
 */
@parentResource(Revision)
model Replica is Azure.ResourceManager.ProxyResource<ReplicaProperties> {
  ...ResourceNameParameter<
    Resource = Replica,
    KeyName = "replicaName",
    SegmentName = "replicas",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContainerAppsRevisionReplicas {
  /**
   * Get a replica for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisionReplicas_GetReplica")
  @summary("Get a replica for a Container App Revision.")
  getReplica is ArmResourceRead<Replica, Error = DefaultErrorResponse>;

  /**
   * List replicas for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisionReplicas_ListReplicas")
  @summary("List replicas for a Container App Revision.")
  listReplicas is ArmResourceListByParent<
    Replica,
    Response = ArmResponse<ReplicaCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(Replica.name, "Name of the Container App Revision Replica.");
@@doc(Replica.properties, "Replica resource specific properties");
