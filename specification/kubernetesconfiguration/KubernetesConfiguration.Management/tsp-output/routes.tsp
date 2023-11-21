import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SourceControlConfigurationClient;

interface ExtensionsOperations {
  @doc("Create a new Kubernetes Cluster Extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Extension.")
      @path
      extensionName: string;

      @doc("Properties necessary to Create an Extension.")
      @body
      extension: Extension;
    },
    Extension
  >;

  @doc("Gets Kubernetes Cluster Extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Extension.")
      @path
      extensionName: string;
    },
    Extension
  >;

  @doc("""
Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall
the extension from the cluster.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Extension.")
      @path
      extensionName: string;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query
      forceDelete: boolean;
    },
    void
  >;

  @doc("Patch an existing Kubernetes Cluster Extension.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Extension.")
      @path
      extensionName: string;

      @doc("Properties to Patch in an existing Extension.")
      @body
      patchExtension: PatchExtension;
    },
    Extension
  >;

  @doc("List all Extensions in the cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;
    },
    ExtensionsList
  >;
}

interface OperationStatusOperations {
  @doc("Get Async Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Extension.")
      @path
      extensionName: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatusResult
  >;

  @doc("List Async Operations, currently in progress, in a cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/operations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;
    },
    OperationStatusList
  >;
}

interface FluxConfigurationsOperations {
  @doc("Gets details of the Flux Configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;
    },
    FluxConfiguration
  >;

  @doc("Create a new Kubernetes Flux Configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;

      @doc("Properties necessary to Create a FluxConfiguration.")
      @body
      fluxConfiguration: FluxConfiguration;
    },
    FluxConfiguration
  >;

  @doc("Update an existing Kubernetes Flux Configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;

      @doc("Properties to Patch in an existing Flux Configuration.")
      @body
      fluxConfigurationPatch: FluxConfigurationPatch;
    },
    FluxConfiguration
  >;

  @doc("""
This will delete the YAML file used to set up the Flux Configuration, thus
stopping future sync from the source repo.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query
      forceDelete: boolean;
    },
    void
  >;

  @doc("List all Flux Configurations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;
    },
    FluxConfigurationsList
  >;
}

interface FluxConfigOperationStatusOperations {
  @doc("Get Async Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatusResult
  >;
}

interface SourceControlConfigurationsOperations {
  @doc("Gets details of the Source Control Configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/sourceControlConfigurations/{sourceControlConfigurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Source Control Configuration.")
      @path
      sourceControlConfigurationName: string;
    },
    SourceControlConfiguration
  >;

  @doc("Create a new Kubernetes Source Control Configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/sourceControlConfigurations/{sourceControlConfigurationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Source Control Configuration.")
      @path
      sourceControlConfigurationName: string;

      @doc("Properties necessary to Create KubernetesConfiguration.")
      @body
      sourceControlConfiguration: SourceControlConfiguration;
    },
    SourceControlConfiguration
  >;

  @doc("""
This will delete the YAML file used to set up the Source control configuration,
thus stopping future sync from the source repo.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/sourceControlConfigurations/{sourceControlConfigurationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Source Control Configuration.")
      @path
      sourceControlConfigurationName: string;
    },
    void
  >;

  @doc("List all Source Control Configurations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/sourceControlConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The Kubernetes cluster RP - i.e. Microsoft.ContainerService,
Microsoft.Kubernetes, Microsoft.HybridContainerService.
""")
      @path
      clusterRp: string;

      @doc("""
The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
provisionedClusters.
""")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;
    },
    SourceControlConfigurationList
  >;
}

interface OperationsOperations {
  @doc("""
List all the available operations the KubernetesConfiguration resource provider
supports.
""")
  @route("/providers/Microsoft.KubernetesConfiguration/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ResourceProviderOperationList>;
}
