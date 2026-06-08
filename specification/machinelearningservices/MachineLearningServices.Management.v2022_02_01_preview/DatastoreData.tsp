import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model DatastoreData
  is Azure.ResourceManager.ProxyResource<DatastoreDetails, false> {
  ...ResourceNameParameter<
    Resource = DatastoreData,
    KeyName = "name",
    SegmentName = "datastores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Datastores {
  /**
   * Get datastore.
   */
  get is ArmResourceRead<DatastoreData>;

  /**
   * Create or update datastore.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DatastoreData,
    Parameters = {
      /**
       * Flag to skip validation.
       */
      @query("skipValidation")
      skipValidation?: boolean;
    }
  >;

  /**
   * Delete datastore.
   */
  delete is ArmResourceDeleteSync<DatastoreData>;

  /**
   * List datastores.
   */
  list is ArmResourceListByParent<
    DatastoreData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Maximum number of results to return.
       */
      @query("count")
      count?: int32 = 30;

      /**
       * Filter down to the workspace default datastore.
       */
      @query("isDefault")
      isDefault?: boolean;

      /**
       * Names of datastores to return.
       */
      @query("names")
      names?: string[];

      /**
       * Text to search for in the datastore names.
       */
      @query("searchText")
      searchText?: string;

      /**
       * Order by property (createdtime | modifiedtime | name).
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * Order by property in ascending order.
       */
      @query("orderByAsc")
      orderByAsc?: boolean;
    },
    Response = ArmResponse<DatastoreResourceArmPaginatedResult>
  >;

  /**
   * Get datastore secrets.
   */
  listSecrets is ArmResourceActionSync<
    DatastoreData,
    void,
    ArmResponse<DatastoreSecrets>
  >;
}

@@doc(DatastoreData.name, "Datastore name.");
@@doc(
  DatastoreData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  Datastores.createOrUpdate::parameters.resource,
  "Datastore entity to create or update."
);
