import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing a Kusto cluster.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = "^.*$"
  >;

  /**
   * The SKU of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: AzureSku;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the cluster, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;

  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets a Kusto cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a Kusto cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Parameters = {
      /**
       * The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new cluster to be created, but to prevent updating an existing cluster. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdate,
    Parameters = {
      /**
       * The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    },
    Response = ArmResponse<Cluster> | ArmResourceCreatedResponse<Cluster> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Cluster;
    })
  >;

  /**
   * Deletes a Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto clusters within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterListResult>
  >;

  /**
   * Lists all Kusto clusters within a subscription.
   */
  list is ArmListBySubscription<
    Cluster,
    Response = ArmResponse<ClusterListResult>
  >;

  /**
   * Stops a Kusto cluster.
   */
  stop is ArmResourceActionAsync<Cluster, void, OkResponse>;

  /**
   * Starts a Kusto cluster.
   */
  start is ArmResourceActionAsync<Cluster, void, OkResponse>;

  /**
   * Migrate data from a Kusto cluster to another cluster.
   */
  migrate is ArmResourceActionAsync<Cluster, ClusterMigrateRequest, OkResponse>;

  /**
   * Returns a list of databases that are owned by this cluster and were followed by another cluster.
   */
  @get
  @action("listFollowerDatabases")
  listFollowerDatabasesGet is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<FollowerDatabaseListResultGet>
  >;

  /**
   * Returns a list of databases that are owned by this cluster and were followed by another cluster.
   */
  listFollowerDatabases is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<FollowerDatabaseListResult>
  >;

  /**
   * Detaches all followers of a database owned by this cluster.
   */
  detachFollowerDatabases is ArmResourceActionAsync<
    Cluster,
    FollowerDatabaseDefinition,
    OkResponse
  >;

  /**
   * Diagnoses network connectivity status for external resources on which the service is dependent on.
   */
  diagnoseVirtualNetwork is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<DiagnoseVirtualNetworkResult>
  >;

  /**
   * Returns the SKUs available for the provided resource.
   */
  @get
  @action("skus")
  listSkusByResource is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ListResourceSkusResult>
  >;

  /**
   * Gets the network endpoints of all outbound dependencies of a Kusto cluster
   */
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ResourceListResult<OutboundNetworkDependenciesEndpoint>>
  >;

  /**
   * Adds a list of callout policies for engine services.
   */
  addCalloutPolicies is ArmResourceActionAsync<
    Cluster,
    CalloutPoliciesList,
    OkResponse
  >;

  /**
   * Removes callout policy for engine services.
   */
  removeCalloutPolicy is ArmResourceActionAsync<
    Cluster,
    CalloutPolicyToRemove,
    OkResponse
  >;

  /**
   * Returns the allowed callout policies for the specified service.
   */
  listCalloutPolicies is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<CalloutPoliciesList>
  >;

  /**
   * Returns a list of language extensions that can run within KQL queries.
   */
  listLanguageExtensions is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<LanguageExtensionsList>
  >;

  /**
   * Add a list of language extensions that can run within KQL queries.
   */
  addLanguageExtensions is ArmResourceActionAsync<
    Cluster,
    LanguageExtensionsList,
    OkResponse
  >;

  /**
   * Remove a list of language extensions that can run within KQL queries.
   */
  removeLanguageExtensions is ArmResourceActionAsync<
    Cluster,
    LanguageExtensionsList,
    OkResponse
  >;

  /**
   * Checks that the principal assignment name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkPrincipalAssignmentNameAvailability")
  @operationId("ClusterPrincipalAssignments_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ClusterPrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the databases resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkNameAvailability")
  @operationId("Databases_CheckNameAvailability")
  databasesCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    CheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the attached database configuration resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("attachedDatabaseConfigurationCheckNameAvailability")
  @operationId("AttachedDatabaseConfigurations_CheckNameAvailability")
  attachedDatabaseConfigurationsCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    AttachedDatabaseConfigurationsCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the managed private endpoints resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedPrivateEndpoints_CheckNameAvailability")
  managedPrivateEndpointsCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    ManagedPrivateEndpointsCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the sandbox custom image resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SandboxCustomImages_CheckNameAvailability")
  sandboxCustomImagesCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    SandboxCustomImagesCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;
}

@@doc(Cluster.name, "The name of the Kusto cluster.");
@@encodedName(Cluster.eTag, "application/json", "etag");
@@doc(Cluster.properties, "The cluster properties.");
@@doc(Clusters.createOrUpdate::parameters.resource,
  "The Kusto cluster parameters supplied to the CreateOrUpdate operation."
);
@@doc(Clusters.update::parameters.properties,
  "The Kusto cluster parameters supplied to the Update operation."
);
@@doc(Clusters.migrate::parameters.body,
  "The cluster migrate request parameters."
);
@@doc(Clusters.detachFollowerDatabases::parameters.body,
  "The follower databases properties to remove."
);
@@doc(Clusters.addCalloutPolicies::parameters.body,
  "The callout policies to add."
);
@@doc(Clusters.removeCalloutPolicy::parameters.body,
  "The callout policies to remove."
);
@@doc(Clusters.addLanguageExtensions::parameters.body,
  "The language extensions to add."
);
@@doc(Clusters.removeLanguageExtensions::parameters.body,
  "The language extensions to remove."
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the principal assignment."
);
@@doc(Clusters.databasesCheckNameAvailability::parameters.body,
  "The name of the resource."
);
@@doc(Clusters.attachedDatabaseConfigurationsCheckNameAvailability::parameters.body,
  "The name of the resource."
);
@@doc(Clusters.managedPrivateEndpointsCheckNameAvailability::parameters.body,
  "The name of the resource."
);
@@doc(Clusters.sandboxCustomImagesCheckNameAvailability::parameters.body,
  "The name of the resource."
);
