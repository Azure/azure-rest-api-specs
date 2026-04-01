import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An elastic pool.
 */
@parentResource(Server)
model ElasticPool
  is Azure.ResourceManager.TrackedResource<ElasticPoolProperties> {
  ...ResourceNameParameter<
    Resource = ElasticPool,
    KeyName = "elasticPoolName",
    SegmentName = "elasticPools",
    NamePattern = ""
  >;

  /**
   * The elastic pool SKU.
   *
   * The list of SKUs may vary by region and support offer. To determine the SKUs (including the SKU name, tier/edition, family, and capacity) that are available to your subscription in an Azure region, use the `Capabilities_ListByLocation` REST API or the following command:
   *
   * ```azurecli
   * az sql elastic-pool list-editions -l <location> -o table
   * ```
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Kind of elastic pool. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations(#{ omitTags: true })
interface ElasticPools {
  /**
   * Gets an elastic pool.
   */
  @tag("ElasticPools")
  get is ArmResourceRead<ElasticPool>;

  /**
   * Creates or updates an elastic pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @tag("ElasticPools")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ElasticPool,
    Response = ArmResourceUpdatedResponse<ElasticPool> | ArmResourceCreatedResponse<
      ElasticPool,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ElasticPool>
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an elastic pool.
   */
  @patch(#{ implicitOptionality: false })
  @tag("ElasticPools")
  update is ArmCustomPatchAsync<ElasticPool, PatchModel = ElasticPoolUpdate>;

  /**
   * Deletes an elastic pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ElasticPools")
  delete is ArmResourceDeleteWithoutOkAsync<
    ElasticPool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all elastic pools in a server.
   */
  @tag("ElasticPools")
  listByServer is ArmResourceListByParent<
    ElasticPool,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;
    }
  >;

  /**
   * Gets a list of databases in an elastic pool.
   */
  @tag("Databases")
  @list
  @get
  @action("databases")
  listByElasticPool is ArmResourceActionSync<
    ElasticPool,
    void,
    ArmResponse<ResourceListResult<Database>>
  >;

  /**
   * Gets a list of operations performed on the elastic pool.
   */
  @tag("ElasticPoolOperations")
  @list
  @get
  @action("operations")
  elasticPoolOperationsListByElasticPool is ArmResourceActionSync<
    ElasticPool,
    void,
    ArmResponse<ResourceListResult<ElasticPoolOperation>>
  >;

  /**
   * Cancels the asynchronous operation on the elastic pool.
   */
  @tag("ElasticPoolOperations")
  cancel is ArmResourceActionSync<
    ElasticPool,
    void,
    OkResponse,
    Parameters = {
      /**
       * The operation identifier.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("operations")
      operationId: Azure.Core.uuid;
    }
  >;

  /**
   * Failovers an elastic pool.
   */
  @tag("ElasticPools")
  failover is ArmResourceActionAsyncBase<
    ElasticPool,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ElasticPool>,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ElasticPool>>
  >;
}

@@doc(ElasticPool.name, "The name of the elastic pool.");
@@doc(ElasticPool.properties, "Resource properties.");
@@doc(ElasticPools.createOrUpdate::parameters.resource,
  "The elastic pool parameters."
);
@@doc(ElasticPools.update::parameters.properties,
  "The elastic pool update parameters."
);
