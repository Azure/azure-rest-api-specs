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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: AzureSku;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the cluster, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface Clusters {
  /**
   * Gets a Kusto cluster.
   */
  @tag("Clusters")
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a Kusto cluster.
   */
  @tag("Clusters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Parameters = {
      /**
       * The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new cluster to be created, but to prevent updating an existing cluster. Other values will result in a 412 Pre-condition Failed response.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Clusters")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdate,
    Parameters = {
      /**
       * The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      IfMatch?: string;
    },
    Response = ArmResponse<Cluster> | ArmResourceCreatedResponse<
      Cluster,
      LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
        ArmAsyncOperationHeader<FinalResult = Cluster> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<
      "Update accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
        ArmAsyncOperationHeader<FinalResult = Cluster> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: Cluster;
    })
  >;

  /**
   * Deletes a Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Clusters")
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto clusters within a resource group.
   */
  @tag("Clusters")
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterListResult>
  >;

  /**
   * Lists all Kusto clusters within a subscription.
   */
  @tag("Clusters")
  list is ArmListBySubscription<
    Cluster,
    Response = ArmResponse<ClusterListResult>
  >;

  /**
   * Stops a Kusto cluster.
   */
  @tag("Clusters")
  stop is ArmResourceActionAsyncBase<
    Cluster,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Starts a Kusto cluster.
   */
  @tag("Clusters")
  start is ArmResourceActionAsyncBase<
    Cluster,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Migrate data from a Kusto cluster to another cluster.
   */
  @tag("Clusters")
  migrate is ArmResourceActionAsyncBase<
    Cluster,
    ClusterMigrateRequest,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Returns a list of databases that are owned by this cluster and were followed by another cluster.
   */
  @tag("Clusters")
  @list
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
  @tag("Clusters")
  @list
  listFollowerDatabases is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<FollowerDatabaseListResult>
  >;

  /**
   * Detaches all followers of a database owned by this cluster.
   */
  @tag("Clusters")
  detachFollowerDatabases is ArmResourceActionAsyncBase<
    Cluster,
    FollowerDatabaseDefinition,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Diagnoses network connectivity status for external resources on which the service is dependent on.
   */
  @tag("Clusters")
  diagnoseVirtualNetwork is ArmResourceActionAsyncBase<
    Cluster,
    void,
    ArmAcceptedLroResponse<
      "Diagnose virtual network request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = DiagnoseVirtualNetworkResult> &
        ArmAsyncOperationHeader<FinalResult = DiagnoseVirtualNetworkResult> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmResponse<DiagnoseVirtualNetworkResult>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Returns the SKUs available for the provided resource.
   */
  @tag("Clusters")
  @list
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
  @tag("OutboundNetworkDependenciesEndpoints")
  @list
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
  @tag("Clusters")
  addCalloutPolicies is ArmResourceActionAsyncBase<
    Cluster,
    CalloutPoliciesList,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Removes callout policy for engine services.
   */
  @tag("Clusters")
  removeCalloutPolicy is ArmResourceActionAsyncBase<
    Cluster,
    CalloutPolicyToRemove,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Returns the allowed callout policies for the specified service.
   */
  @tag("Clusters")
  @list
  listCalloutPolicies is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<CalloutPoliciesList>
  >;

  /**
   * Returns a list of language extensions that can run within KQL queries.
   */
  @tag("Clusters")
  @list
  listLanguageExtensions is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<LanguageExtensionsList>
  >;

  /**
   * Add a list of language extensions that can run within KQL queries.
   */
  @tag("Clusters")
  addLanguageExtensions is ArmResourceActionAsyncBase<
    Cluster,
    LanguageExtensionsList,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Remove a list of language extensions that can run within KQL queries.
   */
  @tag("Clusters")
  removeLanguageExtensions is ArmResourceActionAsyncBase<
    Cluster,
    LanguageExtensionsList,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders = ArmLroLocationHeader &
        ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Checks that the principal assignment name is valid and is not already in use.
   */
  @tag("ClusterPrincipalAssignments")
  @action("checkPrincipalAssignmentNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ClusterPrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the databases resource name is valid and is not already in use.
   */
  @tag("Databases")
  @action("checkNameAvailability")
  databasesCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    CheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the attached database configuration resource name is valid and is not already in use.
   */
  @tag("AttachedDatabaseConfigurations")
  @action("attachedDatabaseConfigurationCheckNameAvailability")
  attachedDatabaseConfigurationsCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    AttachedDatabaseConfigurationsCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the managed private endpoints resource name is valid and is not already in use.
   */
  @tag("ManagedPrivateEndpoints")
  managedPrivateEndpointsCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    ManagedPrivateEndpointsCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the sandbox custom image resource name is valid and is not already in use.
   */
  @tag("SandboxCustomImages")
  sandboxCustomImagesCheckNameAvailability is ArmResourceActionSync<
    Cluster,
    SandboxCustomImagesCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;
}

@@doc(Cluster.name, "The name of the Kusto cluster.");
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
