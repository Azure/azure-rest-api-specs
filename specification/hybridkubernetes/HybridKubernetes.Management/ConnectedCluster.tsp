import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kubernetes;
/**
 * Represents a connected cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(ConnectedClusterProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@subscriptionResource
model ConnectedCluster extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = ConnectedCluster,
    KeyName = "clusterName",
    SegmentName = "connectedClusters",
    NamePattern = ""
  >;

  /**
   * The identity of the connected cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity: ConnectedClusterIdentity;

  /**
   * The kind of connected cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ConnectedClusterKind;

  /**
   * Properties of the connected cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties: ConnectedClusterProperties;
}

@armResourceOperations
interface ConnectedClusters {
  /**
   * Returns the properties of the specified connected cluster, including name, identity, properties, and additional cluster details.
   */
  get is ArmResourceRead<
    ConnectedCluster,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * API to register a new Kubernetes cluster and create or replace a connected cluster tracked resource in Azure Resource Manager (ARM).
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    ConnectedCluster,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * API to update certain properties of the connected cluster resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ConnectedCluster,
    PatchModel = ConnectedClusterPatch,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Delete a connected cluster, removing the tracked resource in Azure Resource Manager (ARM).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConnectedCluster,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * API to enumerate registered connected K8s clusters under a Resource Group
   */
  listByResourceGroup is ArmResourceListByParent<
    ConnectedCluster,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters,
    Response = ArmResponse<ConnectedClusterList>
  >;

  /**
   * API to enumerate registered connected K8s clusters under a Subscription
   */
  listBySubscription is ArmListBySubscription<
    ConnectedCluster,
    Response = ArmResponse<ConnectedClusterList>
  >;

  /**
   * Gets cluster user credentials of the connected cluster with a specified resource group and name.
   */
  listClusterUserCredential is ArmResourceActionSync<
    ConnectedCluster,
    ListClusterUserCredentialProperties,
    ArmResponse<CredentialResults>,
    BaseParameters = Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;
}

@@doc(ConnectedCluster.name,
  "The name of the Kubernetes cluster on which get is called."
);
@@doc(ConnectedCluster.properties,
  "Describes the connected cluster resource properties."
);
@@doc(ConnectedClusters.createOrReplace::parameters.resource,
  "Parameters supplied to Create a Connected Cluster."
);
@@doc(ConnectedClusters.update::parameters.properties,
  "Parameters supplied to update Connected Cluster."
);
@@doc(ConnectedClusters.listClusterUserCredential::parameters.body,
  "ListClusterUserCredential properties"
);
@@summary(ConnectedClusters.listBySubscription,
  "Lists all connected clusters in the given Subscription"
);
@@summary(ConnectedClusters.get,
  "Get the properties of the specified connected cluster."
);
@@summary(ConnectedClusters.createOrReplace,
  "Register a new Kubernetes cluster with Azure Resource Manager."
);
@@summary(ConnectedClusters.update, "Updates a connected cluster.");
@@summary(ConnectedClusters.delete, "Delete a connected cluster.");
@@summary(ConnectedClusters.listClusterUserCredential,
  "Gets cluster user credentials of a connected cluster"
);
@@summary(ConnectedClusters.listByResourceGroup,
  "Lists all connected clusters in the given Resource Group"
);
