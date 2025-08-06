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
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster manager associated with the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Cluster;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location?: string;
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of clusters in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Get a list of clusters in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Trigger the continuation of an update for a cluster with a matching update strategy that has paused after completing a segment of the update.
   */
  continueUpdateVersion is ArmResourceActionAsyncBase<
    Cluster,
    ClusterContinueUpdateVersionParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Deploy the cluster using the rack configuration provided during creation.
   */
  deploy is ArmResourceActionAsyncBase<
    Cluster,
    ClusterDeployParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Triggers the execution of a runtime protection scan to detect and remediate detected issues, in accordance with the cluster configuration.
   */
  scanRuntime is ArmResourceActionAsyncBase<
    Cluster,
    ClusterScanRuntimeParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Update the version of the provided cluster to one of the available supported versions.
   */
  updateVersion is ArmResourceActionAsyncBase<
    Cluster,
    ClusterUpdateVersionParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@encodedName(Cluster.eTag, "application/json", "etag");
@@doc(Cluster.properties, "The list of the resource properties.");
@@doc(Clusters.createOrUpdate::parameters.resource, "The request body.");
@@doc(Clusters.update::parameters.properties, "The request body.");
@@doc(Clusters.continueUpdateVersion::parameters.body, "The request body.");
@@doc(Clusters.deploy::parameters.body, "The request body.");
@@doc(Clusters.scanRuntime::parameters.body, "The request body.");
@@doc(Clusters.updateVersion::parameters.body, "The request body.");
