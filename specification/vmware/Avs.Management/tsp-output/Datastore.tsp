import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A datastore resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(DatastoreProperties)
@includeInapplicableMetadataInPayload(false)
model Datastore extends ProxyResourceBase {
  /**
   * Name of the datastore in the private cloud cluster
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("datastoreName")
  @segment("datastores")
  name: string;

  /**
   * The properties of a datastore resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: DatastoreProperties;
}

@armResourceOperations
interface Datastores {
  /**
   * Get a datastore in a private cloud cluster
   */
  get is ArmResourceRead<Datastore>;

  /**
   * Create or update a datastore in a private cloud cluster
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Datastore>;

  /**
   * Delete a datastore in a private cloud cluster
   */
  delete is ArmResourceDeleteAsync<Datastore>;

  /**
   * List datastores in a private cloud cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Datastores_List")
  list is ArmResourceListByParent<Datastore>;
}

@@projectedName(Datastores.createOrUpdate::parameters.resource,
  "json",
  "datastore"
);
@@extension(Datastores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "datastore"
);
@@doc(Datastores.createOrUpdate::parameters.resource,
  "A datastore in a private cloud cluster"
);
