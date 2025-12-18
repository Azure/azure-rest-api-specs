import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * Cluster represents the on-premises Network Cloud cluster.
 */
model Cluster
  is Azure.ResourceManager.TrackedResource<ClusterProperties, false> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The extended location of the cluster manager associated with the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The type (kind) of the cluster. When specified, the value must exactly match the kind configured on the cluster manager that manages the cluster. If omitted, the service will default the value to the kind value of the cluster manager.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: DeploymentType;
}

@armResourceOperations
interface Clusters {
  /**
   * Get properties of the provided cluster.
   */
  @summary("Retrieve the cluster.")
  get is ArmResourceRead<Cluster>;

  /**
   * Create a new cluster or update the properties of the cluster if it exists.
   */
  @summary("Create or update the cluster.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch the properties of the provided cluster, or update the tags associated with the cluster. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Patch the cluster.")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Cluster,
    PatchModel = ClusterPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Cluster;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster.
   */
  @summary("Delete the cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of clusters in the provided resource group.
   */
  @summary("List clusters in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Get a list of clusters in the provided subscription.
   */
  @summary("List clusters in the subscription.")
  listBySubscription is ArmListBySubscription<
    Cluster,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Trigger the continuation of an update for a cluster with a matching update strategy that has paused after completing a segment of the update.
   */
  @summary("Continue a paused update to the cluster version.")
  continueUpdateVersion is ArmResourceActionAsyncBase<
    Cluster,
    ClusterContinueUpdateVersionParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Deploy the cluster using the rack configuration provided during creation.
   */
  @summary("Deploy the cluster.")
  deploy is ArmResourceActionAsyncBase<
    Cluster,
    ClusterDeployParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Trigger an inspection of the cluster to perform validation and optional corrective actions based on the supplied additional actions and filters.
   */
  @summary("Inspect the cluster.")
  inspect is ArmResourceActionAsyncBase<
    Cluster,
    ClusterInspectParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Triggers the execution of a runtime protection scan to detect and remediate detected issues, in accordance with the cluster configuration.
   */
  @summary("Execute a runtime protection scan on the cluster.")
  scanRuntime is ArmResourceActionAsyncBase<
    Cluster,
    ClusterScanRuntimeParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Update the version of the provided cluster to one of the available supported versions.
   */
  @summary("Update the cluster version.")
  updateVersion is ArmResourceActionAsyncBase<
    Cluster,
    ClusterUpdateVersionParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
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
