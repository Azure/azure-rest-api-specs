import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the cluster.
 */
model Cluster
  is Azure.ResourceManager.TrackedResource<ClusterProperties, false> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface ClustersOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Cluster,
        KeyName = "clusterName",
        SegmentName = "clusters",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Clusters {
  /**
   * Implements cluster GET method.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create Or Update cluster.
   */
  create is ClustersOps.CreateOrUpdateAsync<
    Cluster,
    OptionalRequestBody = true
  >;

  /**
   * API to update certain properties of the cluster resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ClustersOps.CustomPatchSync<
    Cluster,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements cluster DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClustersList>
  >;

  /**
   * List of clusters in a subscription.
   */
  list is ArmListBySubscription<Cluster, Response = ArmResponse<ClustersList>>;
}

@@doc(Cluster.name, "Name of the cluster.");
@@doc(Cluster.properties, "Resource properties.");
@@doc(Clusters.create::parameters.resource, "Request payload.");
@@doc(Clusters.update::parameters.properties, "Resource properties to update.");
