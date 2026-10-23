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
model Datastore is Azure.ResourceManager.ProxyResource<
  DatastoreProperties,
  false
> {
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
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing DatastoresCreateOrUpdateParameters.skipValidation has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Existing DatastoresCreateOrUpdateParameters.skipValidation retains the skipValidation query parameter; preserve wire compatibility."
  @query("skipValidation")
  skipValidation?: boolean = false;
};

alias DatastoresListParameters = {
  /**
   * Continuation token for pagination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.$skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  $skip?: string;

  /**
   * Maximum number of results to return.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.count retains the count query parameter; preserve wire compatibility."
  @query("count")
  count?: int32 = 30;

  /**
   * Filter down to the workspace default datastore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing DatastoresListParameters.isDefault has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.isDefault retains the isDefault query parameter; preserve wire compatibility."
  @query("isDefault")
  isDefault?: boolean;

  /**
   * Names of datastores to return.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.names retains the names query parameter; preserve wire compatibility."
  @query("names")
  names?: string[];

  /**
   * Text to search for in the datastore names.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.searchText retains the searchText query parameter; preserve wire compatibility."
  @query("searchText")
  searchText?: string;

  /**
   * Order by property (createdtime | modifiedtime | name).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.orderBy retains the orderBy query parameter; preserve wire compatibility."
  @query("orderBy")
  orderBy?: string;

  /**
   * Order by property in ascending order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing DatastoresListParameters.orderByAsc has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing DatastoresListParameters.orderByAsc retains the orderByAsc query parameter; preserve wire compatibility."
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
@@doc(
  Datastores.createOrUpdate::parameters.resource,
  "Datastore entity to create or update."
);
@@doc(Datastores.listSecrets::parameters.body, "Secret expiry information.");
