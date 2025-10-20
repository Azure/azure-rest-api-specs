import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB database account.
 */
model DatabaseAccountGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DatabaseAccountGetProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseAccountGetResults,
    KeyName = "accountName",
    SegmentName = "databaseAccounts",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;

  /**
   * Indicates the type of database account. This can only be set at database account creation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: DatabaseAccountKind = DatabaseAccountKind.GlobalDocumentDB;
}

@armResourceOperations
interface DatabaseAccounts {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB database account.
   */
  get is ArmResourceRead<DatabaseAccountGetResults>;

  /**
   * Creates or updates an Azure Cosmos DB database account. The "Update" method is preferred when performing updates on an account.
   */
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<DatabaseAccountGetResults>,
    DatabaseAccountCreateUpdateParameters,
    Response = ArmResponse<DatabaseAccountGetResults> &
      ArmLroLocationHeader<FinalResult = DatabaseAccountGetResults>,
    ErrorResponse = ErrorResponse
  >;

  /**
   * Updates the properties of an existing Azure Cosmos DB database account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DatabaseAccountGetResults,
    PatchModel = DatabaseAccountUpdateParameters,
    Response = ArmResponse<DatabaseAccountGetResults> &
      ArmLroLocationHeader<FinalResult = DatabaseAccountGetResults>
  >;

  /**
   * Deletes an existing Azure Cosmos DB database account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    DatabaseAccountGetResults,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | NoContentResponse
  >;

  /**
   * Lists all the Azure Cosmos DB database accounts available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DatabaseAccountGetResults,
    Response = ArmResponse<DatabaseAccountsListResult>
  >;

  /**
   * Lists all the Azure Cosmos DB database accounts available under the subscription.
   */
  list is ArmListBySubscription<
    DatabaseAccountGetResults,
    Response = ArmResponse<DatabaseAccountsListResult>
  >;

  /**
   * Changes the failover priority for the Azure Cosmos DB database account. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failoverPriorityChange is ArmResourceActionAsyncBase<
    DatabaseAccountGetResults,
    Request = FailoverPolicies,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DatabaseAccountGetResults>
  >;

  /**
   * Lists the access keys for the specified Azure Cosmos DB database account.
   */
  listKeys is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<DatabaseAccountListKeysResult>
  >;

  /**
   * Lists the connection strings for the specified Azure Cosmos DB database account.
   */
  listConnectionStrings is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<DatabaseAccountListConnectionStringsResult>
  >;

  /**
   * Offline the specified region for the specified Azure Cosmos DB database account.
   */
  offlineRegion is ArmResourceActionAsync<
    DatabaseAccountGetResults,
    RegionForOnlineOffline,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = void>
  >;

  /**
   * Online the specified region for the specified Azure Cosmos DB database account.
   */
  onlineRegion is ArmResourceActionAsync<
    DatabaseAccountGetResults,
    RegionForOnlineOffline,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = void>
  >;

  /**
   * Lists the read-only access keys for the specified Azure Cosmos DB database account.
   */
  @get
  @action("readonlykeys")
  getReadOnlyKeys is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<DatabaseAccountListReadOnlyKeysResult>
  >;

  /**
   * Lists the read-only access keys for the specified Azure Cosmos DB database account.
   */
  @action("readonlykeys")
  listReadOnlyKeys is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<DatabaseAccountListReadOnlyKeysResult>
  >;

  /**
   * Regenerates an access key for the specified Azure Cosmos DB database account.
   */
  regenerateKey is ArmResourceActionAsync<
    DatabaseAccountGetResults,
    DatabaseAccountRegenerateKeyParameters,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = void>
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account.
   */
  @list
  @get
  @action("metrics")
  listMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricListResult>,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the usages (most recent data) for the given database account.
   */
  @list
  @get
  @action("usages")
  listUsages is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<UsagesResult>,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      filter?: string;
    }
  >;

  /**
   * Retrieves metric definitions for the given database account.
   */
  @list
  @get
  @action("metricDefinitions")
  listMetricDefinitions is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricDefinitionsListResult>
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account and database.
   */
  @list
  @get
  @action("metrics")
  databaseListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the usages (most recent data) for the given database.
   */
  @list
  @get
  @action("usages")
  databaseListUsages is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<UsagesResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      filter?: string;
    }
  >;

  /**
   * Retrieves metric definitions for the given database.
   */
  @list
  @get
  @action("metricDefinitions")
  databaseListMetricDefinitions is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricDefinitionsListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account and collection.
   */
  @list
  @get
  @action("metrics")
  collectionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the usages (most recent storage data) for the given collection.
   */
  @list
  @get
  @action("usages")
  collectionListUsages is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<UsagesResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      filter?: string;
    }
  >;

  /**
   * Retrieves metric definitions for the given collection.
   */
  @list
  @get
  @action("metricDefinitions")
  collectionListMetricDefinitions is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricDefinitionsListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account, collection and region.
   */
  @list
  @get
  @action("metrics")
  collectionRegionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricListResult>,
    Parameters = {
      /**
       * Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("region")
      region: string;

      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account and region.
   */
  @list
  @get
  @action("metrics")
  databaseAccountRegionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<MetricListResult>,
    Parameters = {
      /**
       * Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("region")
      region: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given account, source and target region. This url is only for PBS and Replication Latency data
   */
  @list
  @get
  @action("percentile/metrics")
  percentileSourceTargetListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PercentileMetricListResult>,
    Parameters = {
      /**
       * Source region from which data is written. Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("sourceRegion")
      sourceRegion: string;

      /**
       * Target region to which data is written. Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("targetRegion")
      targetRegion: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given account target region. This url is only for PBS and Replication Latency data
   */
  @list
  @get
  @action("percentile/metrics")
  percentileTargetListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PercentileMetricListResult>,
    Parameters = {
      /**
       * Target region to which data is written. Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("targetRegion")
      targetRegion: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given database account. This url is only for PBS and Replication Latency data
   */
  @list
  @get
  @action("percentile/metrics")
  percentileListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PercentileMetricListResult>,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given collection and region, split by partition.
   */
  @list
  @get
  @action("partitions/metrics")
  collectionPartitionRegionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PartitionMetricListResult>,
    Parameters = {
      /**
       * Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("region")
      region: string;

      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given collection, split by partition.
   */
  @list
  @get
  @action("partitions/metrics")
  collectionPartitionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PartitionMetricListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the usages (most recent storage data) for the given collection, split by partition.
   */
  @list
  @get
  @action("partitions/usages")
  collectionPartitionListUsages is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PartitionUsagesResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      filter?: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given partition key range id.
   */
  @list
  @get
  @action("metrics")
  partitionKeyRangeIdListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PartitionMetricListResult>,
    Parameters = {
      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * Partition Key Range Id for which to get data.
       */
      @path
      @segment("partitionKeyRangeId")
      partitionKeyRangeId: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;

  /**
   * Retrieves the metrics determined by the given filter for the given partition key range id and region.
   */
  @list
  @get
  @action("metrics")
  partitionKeyRangeIdRegionListMetrics is ArmResourceActionSync<
    DatabaseAccountGetResults,
    void,
    ArmResponse<PartitionMetricListResult>,
    Parameters = {
      /**
       * Cosmos DB region, with spaces between words and each word capitalized.
       */
      @path
      @segment("region")
      region: string;

      /**
       * Cosmos DB database rid.
       */
      @path
      @segment("databases")
      databaseRid: string;

      /**
       * Cosmos DB collection rid.
       */
      @path
      @segment("collections")
      collectionRid: string;

      /**
       * Partition Key Range Id for which to get data.
       */
      @path
      @segment("partitionKeyRangeId")
      partitionKeyRangeId: string;

      /**
       * An OData filter expression that describes a subset of metrics to return. The parameters that can be filtered are name.value (name of the metric, can have an or of multiple names), startTime, endTime, and timeGrain. The supported operator is eq.
       */
      @query("$filter")
      filter: string;
    }
  >;
}

@@maxLength(DatabaseAccountGetResults.name, 50);
@@minLength(DatabaseAccountGetResults.name, 3);
@@doc(DatabaseAccountGetResults.name, "Cosmos DB database account name.");
@@doc(DatabaseAccountGetResults.properties,
  "Properties for the database account."
);
@@doc(DatabaseAccounts.createOrUpdate::parameters.resource,
  "The parameters to provide for the current database account."
);
@@doc(DatabaseAccounts.update::parameters.properties,
  "The parameters to provide for the current database account."
);
@@doc(DatabaseAccounts.failoverPriorityChange::parameters.body,
  "The new failover policies for the database account."
);
@@doc(DatabaseAccounts.offlineRegion::parameters.body,
  "Cosmos DB region to offline for the database account."
);
@@doc(DatabaseAccounts.onlineRegion::parameters.body,
  "Cosmos DB region to online for the database account."
);
@@doc(DatabaseAccounts.regenerateKey::parameters.body,
  "The name of the key to regenerate."
);
