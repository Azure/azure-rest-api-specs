import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A datastore resource
 */
@parentResource(Cluster)
model Datastore is Azure.ResourceManager.ProxyResource<DatastoreProperties> {
  ...ResourceNameParameter<
    Resource = Datastore,
    KeyName = "datastoreName",
    SegmentName = "datastores",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Datastores {
  /**
   * Get a Datastore
   */
  get is ArmResourceRead<Datastore>;

  /**
   * Create a Datastore
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Datastore>;

  /**
   * Delete a Datastore
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Datastore,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Datastore resources by Cluster
   */
  list is ArmResourceListByParent<
    Datastore,
    Response = ArmResponse<DatastoreList>
  >;
}

@@doc(Datastore.name, "Name of the datastore");
@@doc(Datastore.properties,
  "The resource-specific properties for this resource."
);
