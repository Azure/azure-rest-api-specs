import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL managed instance.
 */
model ManagedInstance
  is Azure.ResourceManager.TrackedResource<ManagedInstanceProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstance,
    KeyName = "managedInstanceName",
    SegmentName = "managedInstances",
    NamePattern = ""
  >;

  /**
   * The Azure Active Directory identity of the managed instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: ResourceIdentity;

  /**
   * Managed instance SKU. Allowed values for sku.name: GP_Gen5 (General Purpose, Standard-series); GP_G8IM (General Purpose, Premium-series); GP_G8IH (General Purpose, Premium-series memory optimized); BC_Gen5 (Business Critical, Standard-Series); BC_G8IM (Business Critical, Premium-series); BC_G8IH (Business Critical, Premium-series memory optimized).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface ManagedInstances {
  /**
   * Gets a managed instance.
   */
  get is ArmResourceRead<
    ManagedInstance,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a managed instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstance,
    Response = ArmResourceUpdatedResponse<ManagedInstance> | ArmResourceCreatedResponse<
      ManagedInstance,
      ArmLroLocationHeader<FinalResult = ManagedInstance> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a managed instance.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ManagedInstance,
    PatchModel = ManagedInstanceUpdate
  >;

  /**
   * Deletes a managed instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstance,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of managed instances in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ManagedInstance,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets a list of all managed instances in the subscription.
   */
  list is ArmListBySubscription<
    ManagedInstance,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets a list of inaccessible managed databases in a managed instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabases_ListInaccessibleByInstance")
  @list
  @get
  @action("inaccessibleManagedDatabases")
  listInaccessibleByInstance is ArmResourceActionSync<
    ManagedInstance,
    void,
    ArmResponse<ResourceListResult<ManagedDatabase>>
  >;

  /**
   * Failovers a managed instance.
   */
  failover is ArmResourceActionAsync<
    ManagedInstance,
    void,
    OkResponse,
    Parameters = {
      /**
       * The type of replica to be failed over.
       */
      @query("replicaType")
      replicaType?: ReplicaType;
    }
  >;

  /**
   * Gets the collection of outbound network dependencies for the given managed instance.
   */
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesByManagedInstance is ArmResourceActionSync<
    ManagedInstance,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>
  >;

  /**
   * Reevaluates the inaccessibility state of all managed databases.
   */
  reevaluateInaccessibleDatabaseState is ArmResourceActionAsync<
    ManagedInstance,
    void,
    OkResponse
  >;

  /**
   * Refresh external governance enablement status.
   */
  @action("refreshExternalGovernanceStatus")
  refreshStatus is ArmResourceActionAsync<
    ManagedInstance,
    void,
    ArmResponse<RefreshExternalGovernanceStatusOperationResultMI>
  >;

  /**
   * Starts the managed instance.
   */
  start is ArmResourceActionAsync<
    ManagedInstance,
    void,
    ArmResponse<ManagedInstance>
  >;

  /**
   * Stops the managed instance.
   */
  stop is ArmResourceActionAsync<
    ManagedInstance,
    void,
    ArmResponse<ManagedInstance>
  >;

  /**
   * Get top resource consuming queries of a managed instance.
   */
  @list
  @get
  @action("topqueries")
  listByManagedInstance is ArmResourceActionSync<
    ManagedInstance,
    void,
    ArmResponse<TopQueriesListResult>,
    Parameters = {
      /**
       * How many 'top queries' to return. Default is 5.
       */
      @query("numberOfQueries")
      numberOfQueries?: int32;

      /**
       * Comma separated list of databases to be included into search. All DB's are included if this parameter is not specified.
       */
      @query("databases")
      databases?: string;

      /**
       * Start time for observed period.
       */
      @query("startTime")
      startTime?: string;

      /**
       * End time for observed period.
       */
      @query("endTime")
      endTime?: string;

      /**
       * The time step to be used to summarize the metric values. Default value is PT1H
       */
      @query("interval")
      interval?: QueryTimeGrainType;

      /**
       * Aggregation function to be used, default value is 'sum'
       */
      @query("aggregationFunction")
      aggregationFunction?: AggregationFunctionType;

      /**
       * Metric to be used for ranking top queries. Default is 'cpu'
       */
      @query("observationMetric")
      observationMetric?: MetricType;
    }
  >;

  /**
   * Validates customer managed key.
   */
  validateAzureKeyVaultEncryptionKey is ArmResourceActionAsync<
    ManagedInstance,
    ManagedInstanceValidateAzureKeyVaultEncryptionKeyRequest,
    OkResponse
  >;

  /**
   * Creates a TDE certificate for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedInstanceTdeCertificates_Create")
  @action("tdeCertificates")
  create is ArmResourceActionAsync<ManagedInstance, TdeCertificate, OkResponse>;

  /**
   * Gets a server trust groups by instance name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerTrustGroups_ListByInstance")
  @list
  @get
  @action("serverTrustGroups")
  listByInstance is ArmResourceActionSync<
    ManagedInstance,
    void,
    ArmResponse<ResourceListResult<ServerTrustGroup>>
  >;
}

@@doc(ManagedInstance.name, "The name of the managed instance.");
@@doc(ManagedInstance.properties, "Resource properties.");
@@doc(ManagedInstances.createOrUpdate::parameters.resource,
  "The requested managed instance resource state."
);
@@doc(ManagedInstances.update::parameters.properties,
  "The requested managed instance resource state."
);
@@doc(ManagedInstances.validateAzureKeyVaultEncryptionKey::parameters.body,
  "The validate azure key vault encryption key parameters."
);
@@doc(ManagedInstances.create::parameters.body,
  "The requested TDE certificate to be created or updated."
);
