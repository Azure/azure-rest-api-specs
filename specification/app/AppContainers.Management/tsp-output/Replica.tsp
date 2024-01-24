import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Revision.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Revision Replica.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Revision)
@Azure.ResourceManager.Private.armResourceInternal(ReplicaProperties)
@includeInapplicableMetadataInPayload(false)
model Replica extends ProxyResourceBase {
  /**
   * Name of the Container App Revision Replica.
   */
  @path
  @key("replicaName")
  @segment("replicas")
  name: string;

  /**
   * Replica resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ReplicaProperties;
}

@armResourceOperations
interface Replicas {
  /**
   * Get a replica for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisionReplicas_GetReplica")
  getReplica is ArmResourceRead<Replica>;

  /**
   * List replicas for a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisionReplicas_ListReplicas")
  listReplicas is ArmResourceListByParent<Replica>;
}
