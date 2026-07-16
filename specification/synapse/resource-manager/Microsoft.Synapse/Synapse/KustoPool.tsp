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

namespace Microsoft.Synapse;
/**
 * Class representing a Kusto kusto pool.
 */
@parentResource(Workspace)
model KustoPool is Azure.ResourceManager.TrackedResource<KustoPoolProperties> {
  ...ResourceNameParameter<
    Resource = KustoPool,
    KeyName = "kustoPoolName",
    SegmentName = "kustoPools",
    NamePattern = ""
  >;

  /**
   * The SKU of the kusto pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: AzureSku;

  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface KustoPools {
  /**
   * Gets a Kusto pool.
   */
  get is ArmResourceRead<KustoPool>;

  /**
   * Create or update a Kusto pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KustoPool,
    Parameters = {
      /**
       * The ETag of the Kusto Pool. Omit this value to always overwrite the current Kusto Pool. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new Kusto Pool to be created, but to prevent updating an existing Kusto Pool. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Kusto Kusto Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    KustoPool,
    PatchModel = KustoPoolUpdate,
    Parameters = {
      /**
       * The ETag of the Kusto Pool. Omit this value to always overwrite the current Kusto Pool. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    },
    Response =
      | ArmResponse<KustoPool>
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: KustoPool;
        })
  >;

  /**
   * Deletes a Kusto pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    KustoPool,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List all Kusto pools
   */
  listByWorkspace is ArmResourceListByParent<
    KustoPool,
    Response = ArmResponse<KustoPoolListResult>
  >;

  /**
   * Stops a Kusto pool.
   */
  stop is ArmResourceActionAsync<KustoPool, void, OkResponse>;

  /**
   * Starts a Kusto pool.
   */
  start is ArmResourceActionAsync<KustoPool, void, OkResponse>;

  /**
   * Returns the SKUs available for the provided resource.
   */
  @get
  @action("skus")
  listSkusByResource is ArmResourceActionSync<
    KustoPool,
    void,
    ArmResponse<ListResourceSkusResult>
  >;

  /**
   * Returns a list of language extensions that can run within KQL queries.
   */
  listLanguageExtensions is ArmResourceActionSync<
    KustoPool,
    void,
    ArmResponse<LanguageExtensionsList>
  >;

  /**
   * Add a list of language extensions that can run within KQL queries.
   */
  addLanguageExtensions is ArmResourceActionAsync<
    KustoPool,
    LanguageExtensionsList,
    OkResponse
  >;

  /**
   * Remove a list of language extensions that can run within KQL queries.
   */
  removeLanguageExtensions is ArmResourceActionAsync<
    KustoPool,
    LanguageExtensionsList,
    OkResponse
  >;

  /**
   * Returns a list of databases that are owned by this Kusto Pool and were followed by another Kusto Pool.
   */
  listFollowerDatabases is ArmResourceActionSync<
    KustoPool,
    void,
    ArmResponse<FollowerDatabaseListResult>
  >;

  /**
   * Detaches all followers of a database owned by this Kusto Pool.
   */
  detachFollowerDatabases is ArmResourceActionAsync<
    KustoPool,
    FollowerDatabaseDefinition,
    OkResponse
  >;

  /**
   * Checks that the Kusto Pool child resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolChildResource_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    KustoPool,
    DatabaseCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the principal assignment name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkPrincipalAssignmentNameAvailability")
  @operationId("KustoPoolPrincipalAssignments_CheckNameAvailability")
  kustoPoolPrincipalAssignmentsCheckNameAvailability is ArmResourceActionSync<
    KustoPool,
    ClusterPrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Lists all Kusto pool PrivateLinkResources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("KustoPoolPrivateLinkResources_List")
  list is ArmResourceActionSync<
    KustoPool,
    void,
    ArmResponse<PrivateLinkResources>
  >;
}

@@doc(KustoPool.name, "The name of the Kusto pool.");
@@encodedName(KustoPool.eTag, "application/json", "etag");
@@doc(KustoPool.properties, "The kusto pool properties.");
@@doc(
  KustoPools.createOrUpdate::parameters.resource,
  "The Kusto pool parameters supplied to the CreateOrUpdate operation."
);
@@doc(
  KustoPools.update::parameters.properties,
  "The Kusto pool parameters supplied to the Update operation."
);
@@doc(
  KustoPools.addLanguageExtensions::parameters.body,
  "The language extensions to add."
);
@@doc(
  KustoPools.removeLanguageExtensions::parameters.body,
  "The language extensions to remove."
);
@@doc(
  KustoPools.detachFollowerDatabases::parameters.body,
  "The follower databases properties to remove."
);
@@doc(
  KustoPools.checkNameAvailability::parameters.body,
  "The name of the Kusto Pool child resource."
);
@@doc(
  KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability::parameters.body,
  "The name of the principal assignment."
);
