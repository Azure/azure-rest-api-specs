import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Cluster_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;
/**
 * The name of the cluster.
 */
model ClusterNameParameter
  is ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * Cluster represents the on-premises Network Cloud cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model Cluster
  is Azure.ResourceManager.TrackedResource<ClusterProperties, false> {
  ...ClusterNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Unable to use template due to Versioning.@added not being applicable to ...spread operations"
  @added(Versions.v2026_01_01_preview)
  @doc("The type (kind) of the cluster. When specified, the value must exactly match the kind configured on the cluster manager that manages the cluster. If omitted, the service will default the value to the kind value of the cluster manager.")
  @pattern("^[-\\w\\._,\\(\\\\\\)]+$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: DeploymentType;
}

@armResourceOperations
interface Clusters {
  /**
   * Get properties of the provided cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create a new cluster or update the properties of the cluster if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Cluster>
  >;

  /**
   * Patch the properties of the provided cluster, or update the tags associated with the cluster. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Cluster,
    PatchModel = ClusterPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Cluster> &
      ArmLroLocationHeader<FinalResult = Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of clusters in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Get a list of clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    Cluster,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Trigger the continuation of an update for a cluster with a matching update strategy that has paused after completing a segment of the update.
   */
  continueUpdateVersion is ActionAsync<
    Cluster,
    ClusterContinueUpdateVersionParameters,
    OperationStatusResult
  >;

  /**
   * Deploy the cluster using the rack configuration provided during creation.
   */
  deploy is ActionAsync<
    Cluster,
    ClusterDeployParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Trigger an inspection of the cluster to perform validation and optional corrective actions based on the supplied additional actions and filters.
   */
  @added(Versions.v2026_01_01_preview)
  inspect is ActionAsync<
    Cluster,
    ClusterInspectParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Triggers the execution of a runtime protection scan to detect and remediate detected issues, in accordance with the cluster configuration.
   */
  scanRuntime is ActionAsync<
    Cluster,
    ClusterScanRuntimeParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Update the version of the provided cluster to one of the available supported versions.
   */
  updateVersion is ActionAsync<
    Cluster,
    ClusterUpdateVersionParameters,
    OperationStatusResult
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "The list of the resource properties.");
@@doc(Clusters.createOrUpdate::parameters.resource, "The request body.");
@@doc(Clusters.update::parameters.properties, "The request body.");
@@doc(Clusters.continueUpdateVersion::parameters.body, "The request body.");
@@doc(Clusters.deploy::parameters.body, "The request body.");
@@doc(Clusters.inspect::parameters.body, "The request body.");
@@doc(Clusters.scanRuntime::parameters.body, "The request body.");
@@doc(Clusters.updateVersion::parameters.body, "The request body.");
