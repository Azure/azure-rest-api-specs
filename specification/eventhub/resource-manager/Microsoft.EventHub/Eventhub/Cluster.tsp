import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single Event Hubs Cluster resource in List or Get operations.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy behavior required for backward compatibility with the original OpenAPI specification."
model Cluster
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * Properties of the cluster SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is an existing envelope property from the original OpenAPI specification and cannot be changed without breaking compatibility."
  sku?: ClusterSku;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets the resource description of the specified Event Hubs Cluster.
   */
  get is ArmResourceRead<Cluster, Error = ErrorResponse>;

  /**
   * Creates or updates an instance of an Event Hubs Cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing PUT operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Response = ArmResourceUpdatedResponse<Cluster> | ArmResourceCreatedResponse<Cluster> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Modifies mutable properties on the Event Hubs Cluster. This operation is idempotent.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = Cluster,
    Response = ArmResponse<Cluster> | ArmResourceCreatedResponse<Cluster> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing Event Hubs Cluster. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing DELETE operation response codes match the original OpenAPI specification. Changing would be a breaking change for existing clients."
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the available Event Hubs Clusters within an ARM resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Error = ErrorResponse
  >;

  /**
   * Lists the available Event Hubs Clusters within an ARM resource group
   */
  listBySubscription is ArmListBySubscription<Cluster, Error = ErrorResponse>;

  /**
   * List all Event Hubs Namespace IDs in an Event Hubs Dedicated Cluster.
   */
  @get
  @action("namespaces")
  listNamespaces is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<EHNamespaceIdListResult>,
    Error = ErrorResponse
  >;

  /**
   * Replace all specified Event Hubs Cluster settings with those contained in the request body. Leaves the settings not specified in the request body unmodified.
   */
  #suppress "@typespec/http/patch-implicit-optional" "PATCH operation properties are explicitly defined as required/optional matching the original OpenAPI specification."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing long-running operation does not use the standard location header pattern as defined in the original OpenAPI specification."
  @patch
  @action("quotaConfiguration/default")
  patch is ArmResourceActionSync<
    Cluster,
    ClusterQuotaConfigurationProperties,
    ArmResponse<ClusterQuotaConfigurationProperties> | ArmResourceCreatedSyncResponse<ClusterQuotaConfigurationProperties> | AcceptedResponse,
    Error = ErrorResponse
  >;

  /**
   * Get all Event Hubs Cluster settings - a collection of key/value pairs which represent the quotas and settings imposed on the cluster.
   */
  @get
  @action("quotaConfiguration/default")
  configurationGet is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ClusterQuotaConfigurationProperties>,
    Error = ErrorResponse
  >;
}

@@maxLength(Cluster.name, 50);
@@minLength(Cluster.name, 6);
@@doc(Cluster.name, "The name of the Event Hubs Cluster.");
@@doc(Cluster.properties,
  "Event Hubs Cluster properties supplied in responses in List or Get operations."
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "Parameters for creating a eventhub cluster resource."
);
@@doc(Clusters.update::parameters.properties,
  "The properties of the Event Hubs Cluster which should be updated."
);
@@doc(Clusters.patch::parameters.body,
  "Parameters for creating an Event Hubs Cluster resource."
);
