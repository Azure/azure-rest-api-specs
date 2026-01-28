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
model Datastore
  is Azure.ResourceManager.ProxyResource<DatastoreProperties, false> {
  ...ResourceNameParameter<
    Resource = Datastore,
    KeyName = "name",
    SegmentName = "datastores",
    NamePattern = ""
  >;
}

alias DatastoresCreateOrUpdateParameters = {
  /**
   * Flag to skip validation.
   */
  @query("skipValidation")
  skipValidation?: boolean = false;
};

alias DatastoresListParameters = {
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
  orderByAsc?: boolean = false;
};

@armResourceOperations
interface Datastores {
  /**
   * Get datastore.
   */
  @summary("Get datastore.")
  get is ArmResourceRead<Datastore>;

  /**
   * Create or update datastore.
   */
  @summary("Create or update datastore.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Datastore,
    Parameters = DatastoresCreateOrUpdateParameters
  >;

  /**
   * Delete datastore.
   */
  @summary("Delete datastore.")
  delete is ArmResourceDeleteSync<Datastore>;

  /**
   * List datastores.
   */
  @summary("List datastores.")
  list is ArmResourceListByParent<
    Datastore,
    Parameters = DatastoresListParameters,
    Response = ArmResponse<DatastoreResourceArmPaginatedResult>
  >;

  /**
   * Get datastore secrets.
   */
  @summary("Get datastore secrets.")
  listSecrets is ArmResourceActionSync<
    Datastore,
    SecretExpiry,
    ArmResponse<DatastoreSecrets>,
    OptionalRequestBody = true
  >;
}

@@doc(Datastore.name, "Datastore name.");
@@doc(Datastore.properties, "[Required] Additional attributes of the entity.");
@@doc(Datastores.createOrUpdate::parameters.resource,
  "Datastore entity to create or update."
);
@@doc(Datastores.listSecrets::parameters.body, "Secret expiry information.");
