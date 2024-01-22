import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Description of hybrid connection resource.
 */
@parentResource(RelayNamespace)
model HybridConnection is ProxyResource<HybridConnectionProperties> {
  /**
   * The hybrid connection name.
   */
  @minLength(1)
  @path
  @key("hybridConnectionName")
  @segment("hybridConnections")
  name: string;
}

@armResourceOperations
interface HybridConnections {
  /**
   * Returns the description for the specified hybrid connection.
   */
  get is ArmResourceRead<HybridConnection>;

  /**
   * Creates or updates a service hybrid connection. This operation is idempotent.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HybridConnection>;

  /**
   * Deletes a hybrid connection.
   */
  delete is ArmResourceDeleteSync<HybridConnection>;

  /**
   * Lists the hybrid connection within the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridConnections_ListByNamespace")
  listByNamespace is ArmResourceListByParent<HybridConnection>;
}

@@projectedName(HybridConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(HybridConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(HybridConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to create a hybrid connection."
);
