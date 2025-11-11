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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The extended location of the cluster manager associated with the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The type (kind) of the cluster. When specified, the value must exactly match the kind configured on the cluster manager that manages the cluster. If omitted, the service will default the value to the kind value of the cluster manager.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch the properties of the provided cluster, or update the tags associated with the cluster. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Cluster,
    PatchModel = ClusterPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Cluster;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of clusters in the provided resource group.
   */
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
  continueUpdateVersion is ArmResourceActionAsync<
    Cluster,
    ClusterContinueUpdateVersionParameters,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Deploy the cluster using the rack configuration provided during creation.
   */
  deploy is ArmResourceActionAsync<
    Cluster,
    ClusterDeployParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Trigger an inspection of the cluster to perform validation and optional corrective actions based on the supplied additional actions and filters.
   */
  inspect is ArmResourceActionAsync<
    Cluster,
    ClusterInspectParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Triggers the execution of a runtime protection scan to detect and remediate detected issues, in accordance with the cluster configuration.
   */
  scanRuntime is ArmResourceActionAsync<
    Cluster,
    ClusterScanRuntimeParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Update the version of the provided cluster to one of the available supported versions.
   */
  updateVersion is ArmResourceActionAsync<
    Cluster,
    ClusterUpdateVersionParameters,
    ArmResponse<OperationStatusResult>
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
