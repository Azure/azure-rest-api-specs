import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace KustoPools;
/**
 * Class representing a Kusto kusto pool.
 */
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

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "EntityTagProperty models the read-only etag that the published KustoPool resource already returns."
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias KustoPoolOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** The name of the Kusto pool. */
    @segment("kustoPools")
    @key
    @path
    kustoPoolName: string;
  }
>;

@armResourceOperations
interface KustoPools {
  /**
   * Gets a Kusto pool.
   */
  get is KustoPoolOps.Read<KustoPool>;

  /**
   * Create or update a Kusto pool.
   */
  createOrUpdate is KustoPoolOps.CreateOrUpdateAsync<
    KustoPool,
    Parameters = {
      /**
       * The ETag of the Kusto Pool. Omit this value to always overwrite the current Kusto Pool. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header("If-Match")
      ifMatch?: string;

      /**
       * Set to '*' to allow a new Kusto Pool to be created, but to prevent updating an existing Kusto Pool. Other values will result in a 412 Pre-condition Failed response.
       */
      @header("If-None-Match")
      ifNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = KustoPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Kusto Kusto Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is KustoPoolOps.CustomPatchAsync<
    KustoPool,
    PatchModel = KustoPoolUpdate,
    Parameters = {
      /**
       * The ETag of the Kusto Pool. Omit this value to always overwrite the current Kusto Pool. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header("If-Match")
      ifMatch?: string;
    },
    Response =
      | ArmResponse<KustoPool>
      | (ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmLroLocationHeader<FinalResult = KustoPool> &
            Azure.Core.Foundations.RetryAfterHeader
        > & {
          @bodyRoot
          _: KustoPool;
        })
  >;

  /**
   * Deletes a Kusto pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is KustoPoolOps.DeleteWithoutOkAsync<
    KustoPool,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List all Kusto pools
   */
  listByWorkspace is KustoPoolOps.List<
    KustoPool,
    Response = ArmResponse<KustoPoolListResult>
  >;

  /**
   * Stops a Kusto pool.
   */
  stop is KustoPoolOps.ActionAsync<
    KustoPool,
    void,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Starts a Kusto pool.
   */
  start is KustoPoolOps.ActionAsync<
    KustoPool,
    void,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Returns the SKUs available for the provided resource.
   */
  @list
  @get
  @action("skus")
  listSkusByResource is KustoPoolOps.ActionSync<
    KustoPool,
    void,
    ArmResponse<ListResourceSkusResult>
  >;

  /**
   * Returns a list of language extensions that can run within KQL queries.
   */
  @list
  listLanguageExtensions is KustoPoolOps.ActionSync<
    KustoPool,
    void,
    ArmResponse<LanguageExtensionsList>
  >;

  /**
   * Add a list of language extensions that can run within KQL queries.
   */
  addLanguageExtensions is KustoPoolOps.ActionAsync<
    KustoPool,
    LanguageExtensionsList,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Remove a list of language extensions that can run within KQL queries.
   */
  removeLanguageExtensions is KustoPoolOps.ActionAsync<
    KustoPool,
    LanguageExtensionsList,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Returns a list of databases that are owned by this Kusto Pool and were followed by another Kusto Pool.
   */
  @list
  listFollowerDatabases is KustoPoolOps.ActionSync<
    KustoPool,
    void,
    ArmResponse<FollowerDatabaseListResult>
  >;

  /**
   * Detaches all followers of a database owned by this Kusto Pool.
   */
  detachFollowerDatabases is KustoPoolOps.ActionAsync<
    KustoPool,
    FollowerDatabaseDefinition,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Checks that the Kusto Pool child resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolChildResource_CheckNameAvailability")
  checkNameAvailability is KustoPoolOps.ActionSync<
    KustoPool,
    DatabaseCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the principal assignment name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolPrincipalAssignments_CheckNameAvailability")
  @action("checkPrincipalAssignmentNameAvailability")
  kustoPoolPrincipalAssignmentsCheckNameAvailability is KustoPoolOps.ActionSync<
    KustoPool,
    ClusterPrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Lists all Kusto pool PrivateLinkResources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolPrivateLinkResources_List")
  @list
  @get
  @action("privateLinkResources")
  list is KustoPoolOps.ActionSync<
    KustoPool,
    void,
    ArmResponse<PrivateLinkResources>
  >;
}

@@doc(KustoPool.name, "The name of the Kusto pool.");
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
