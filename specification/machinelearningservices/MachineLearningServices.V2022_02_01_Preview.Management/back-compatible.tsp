import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SharedPrivateLinkResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClusterUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(Workspaces.update::parameters.properties, "parameters");
@@clientName(Workspaces.diagnose::parameters.body, "parameters");
@@clientLocation(Workspaces.list, "PrivateLinkResources");
@@clientLocation(Workspaces.workspaceFeaturesList, "WorkspaceFeatures");
@@clientName(Workspaces.workspaceFeaturesList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Workspace.properties);

@@clientName(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ComputeResources.get, "Compute");
@@clientLocation(ComputeResources.createOrUpdate, "Compute");
@@clientName(
  ComputeResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ComputeResources.update, "Compute");
@@clientName(ComputeResources.update::parameters.properties, "parameters");
@@clientLocation(ComputeResources.delete, "Compute");
@@clientLocation(ComputeResources.list, "Compute");
@@clientLocation(ComputeResources.listNodes, "Compute");
@@clientLocation(ComputeResources.listKeys, "Compute");
@@clientLocation(ComputeResources.start, "Compute");
@@clientLocation(ComputeResources.stop, "Compute");
@@clientLocation(ComputeResources.restart, "Compute");

@@clientName(WorkspaceConnections.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceConnection.properties);

@@clientName(BatchEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(BatchEndpoints.update::parameters.properties, "body");

@@clientName(BatchDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(BatchDeployments.update::parameters.properties, "body");

@@clientName(CodeContainers.createOrUpdate::parameters.resource, "body");

@@clientName(CodeVersions.createOrUpdate::parameters.resource, "body");

@@clientName(ComponentContainers.createOrUpdate::parameters.resource, "body");

@@clientName(ComponentVersions.createOrUpdate::parameters.resource, "body");

@@clientName(DataContainers.createOrUpdate::parameters.resource, "body");

@@clientName(DataVersions.createOrUpdate::parameters.resource, "body");

@@clientName(Datastores.createOrUpdate::parameters.resource, "body");

@@clientName(EnvironmentContainers.createOrUpdate::parameters.resource, "body");

@@clientName(EnvironmentVersions.createOrUpdate::parameters.resource, "body");

@@clientName(Jobs.createOrUpdate::parameters.resource, "body");

@@clientName(ModelContainers.createOrUpdate::parameters.resource, "body");

@@clientName(ModelVersions.createOrUpdate::parameters.resource, "body");

@@clientName(OnlineEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineEndpoints.update::parameters.properties, "body");

@@clientName(OnlineDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineDeployments.update::parameters.properties, "body");

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientLocation(VirtualMachineSizesOperationGroup.list, "VirtualMachineSizes");

@@clientLocation(QuotasOperationGroup.update, "Quotas");
@@clientLocation(QuotasOperationGroup.list, "Quotas");
