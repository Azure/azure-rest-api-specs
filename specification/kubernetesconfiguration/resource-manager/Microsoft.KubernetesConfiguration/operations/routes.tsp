// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace OperationsClient;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusOperationGroup {
  /**
   * List Async Operations, currently in progress, in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationStatus_List")
  @autoRoute
  @get
  @action("operations")
  list is ArmProviderActionSync<
    Response = OperationStatusList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.
       */
      @path
      @segment("providers")
      clusterRp: string;

      /**
       * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters.
       */
      @path
      @segment("{clusterRp}")
      clusterResourceName: string;

      /**
       * The name of the kubernetes cluster.
       */
      @path
      @segment("{clusterResourceName}")
      clusterName: string;
    }
  >;
}
