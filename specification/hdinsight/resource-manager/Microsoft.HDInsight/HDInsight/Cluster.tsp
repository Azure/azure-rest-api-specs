import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * The HDInsight cluster.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterGetProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * The ETag for the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the cluster, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ClusterIdentity;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets the specified cluster.
   */
  get is ArmResourceRead<Cluster, Error = ErrorResponse>;

  /**
   * Creates a new HDInsight cluster with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Cluster,
    Request = ClusterCreateParametersExtended,
    Response = ArmResourceUpdatedResponse<Cluster> & {
      ...ArmLroLocationHeader<FinalResult = Cluster>;
      ...Azure.Core.Foundations.RetryAfterHeader;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Patch HDInsight cluster with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Cluster,
    PatchModel = ClusterPatchParameters,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the HDInsight clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Error = ErrorResponse
  >;

  /**
   * Lists all the HDInsight clusters under the subscription.
   */
  list is ArmListBySubscription<Cluster, Error = ErrorResponse>;

  /**
   * Resizes the specified HDInsight cluster to the specified size.
   */
  resize is ArmResourceActionAsyncBase<
    Cluster,
    ClusterResizeParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Parameters = {
      /**
       * The constant value for the roleName
       */
      @path
      @segment("roles")
      @key
      roleName: RoleName;
    },
    Error = ErrorResponse
  >;

  /**
   * Updates the Autoscale Configuration for HDInsight cluster.
   */
  @action("autoscale")
  updateAutoScaleConfiguration is ArmResourceActionAsyncBase<
    Cluster,
    AutoscaleConfigurationUpdateParameter,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Parameters = {
      /**
       * The constant value for the roleName
       */
      @path
      @segment("roles")
      @key
      roleName: RoleName;
    },
    Error = ErrorResponse
  >;

  /**
   * Rotate disk encryption key of the specified HDInsight cluster.
   */
  @action("rotatediskencryptionkey")
  rotateDiskEncryptionKey is ArmResourceActionAsyncBase<
    Cluster,
    ClusterDiskEncryptionParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the gateway settings for the specified cluster.
   */
  getGatewaySettings is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<GatewaySettings>,
    Error = ErrorResponse
  >;

  /**
   * Configures the gateway settings on the specified cluster.
   */
  updateGatewaySettings is ArmResourceActionAsyncBase<
    Cluster,
    UpdateGatewaySettingsParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * The the async operation status.
   */
  getAzureAsyncOperationStatus is ArmResourceRead<
    Cluster,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The long running operation id.
       */
      @path
      @segment("azureasyncoperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Updates the cluster identity certificate.
   */
  @action("updateClusterIdentityCertificate")
  updateIdentityCertificate is ArmResourceActionAsyncBase<
    Cluster,
    UpdateClusterIdentityCertificateParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Executes script actions on the specified HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  executeScriptActions is ArmResourceActionAsyncBase<
    Cluster,
    ExecuteScriptActionParameters,
    OkResponse | ClustersExecuteScriptActionsBadRequestError | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "The properties of the cluster.");
@@doc(Clusters.create::parameters.resource, "The cluster create request.");
@@doc(Clusters.update::parameters.properties, "The cluster patch request.");
@@doc(Clusters.resize::parameters.body,
  "The parameters for the resize operation."
);
@@doc(Clusters.updateAutoScaleConfiguration::parameters.body,
  "The parameters for the update autoscale configuration operation."
);
@@doc(Clusters.rotateDiskEncryptionKey::parameters.body,
  "The parameters for the disk encryption operation."
);
@@doc(Clusters.updateGatewaySettings::parameters.body,
  "The cluster configurations."
);
@@doc(Clusters.updateIdentityCertificate::parameters.body,
  "The cluster configurations."
);
@@doc(Clusters.executeScriptActions::parameters.body,
  "The parameters for executing script actions."
);
