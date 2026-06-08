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
@@clientLocation(ComputeResources.updateCustomServices, "Compute");
@@clientName(
  ComputeResources.updateCustomServices::parameters.body,
  "customServices"
);
@@clientLocation(ComputeResources.listNodes, "Compute");
@@clientLocation(ComputeResources.listKeys, "Compute");
@@clientLocation(ComputeResources.start, "Compute");
@@clientLocation(ComputeResources.stop, "Compute");
@@clientLocation(ComputeResources.restart, "Compute");
@@clientLocation(ComputeResources.updateIdleShutdownSetting, "Compute");
@@clientName(
  ComputeResources.updateIdleShutdownSetting::parameters.body,
  "parameters"
);

@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.get,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.create,
  "WorkspaceConnections"
);
@@clientName(
  WorkspaceConnectionPropertiesV2BasicResources.create::parameters.resource,
  "parameters"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.delete,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.list,
  "WorkspaceConnections"
);

@@clientLocation(CodeContainers.get, "RegistryCodeContainers");
@@clientLocation(CodeContainers.createOrUpdate, "RegistryCodeContainers");
@@clientName(CodeContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(CodeContainers.delete, "RegistryCodeContainers");
@@clientLocation(CodeContainers.list, "RegistryCodeContainers");
@@clientLocation(CodeContainerOperationGroup.get, CodeContainers);
@@clientLocation(CodeContainerOperationGroup.createOrUpdate, CodeContainers);
@@clientName(
  CodeContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeContainerOperationGroup.delete, CodeContainers);
@@clientLocation(CodeContainerOperationGroup.list, CodeContainers);

@@clientLocation(CodeVersions.get, "RegistryCodeVersions");
@@clientLocation(CodeVersions.createOrUpdate, "RegistryCodeVersions");
@@clientName(CodeVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(CodeVersions.delete, "RegistryCodeVersions");
@@clientLocation(CodeVersions.list, "RegistryCodeVersions");
@@clientLocation(CodeVersionOperationGroup.get, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.createOrUpdate, CodeVersions);
@@clientName(
  CodeVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeVersionOperationGroup.delete, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.list, CodeVersions);

@@clientLocation(ComponentContainers.get, "RegistryComponentContainers");
@@clientLocation(
  ComponentContainers.createOrUpdate,
  "RegistryComponentContainers"
);
@@clientName(ComponentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(ComponentContainers.delete, "RegistryComponentContainers");
@@clientLocation(ComponentContainers.list, "RegistryComponentContainers");
@@clientLocation(ComponentContainerOperationGroup.get, ComponentContainers);
@@clientLocation(
  ComponentContainerOperationGroup.createOrUpdate,
  ComponentContainers
);
@@clientName(
  ComponentContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ComponentContainerOperationGroup.delete, ComponentContainers);
@@clientLocation(ComponentContainerOperationGroup.list, ComponentContainers);

@@clientLocation(ComponentVersions.get, "RegistryComponentVersions");
@@clientLocation(ComponentVersions.createOrUpdate, "RegistryComponentVersions");
@@clientName(ComponentVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(ComponentVersions.delete, "RegistryComponentVersions");
@@clientLocation(ComponentVersions.list, "RegistryComponentVersions");
@@clientLocation(ComponentVersionOperationGroup.get, ComponentVersions);
@@clientLocation(
  ComponentVersionOperationGroup.createOrUpdate,
  ComponentVersions
);
@@clientName(
  ComponentVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ComponentVersionOperationGroup.delete, ComponentVersions);
@@clientLocation(ComponentVersionOperationGroup.list, ComponentVersions);

@@clientLocation(EnvironmentContainers.get, "RegistryEnvironmentContainers");
@@clientLocation(
  EnvironmentContainers.createOrUpdate,
  "RegistryEnvironmentContainers"
);
@@clientName(EnvironmentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentContainers.delete, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainers.list, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainerOperationGroup.get, EnvironmentContainers);
@@clientLocation(
  EnvironmentContainerOperationGroup.createOrUpdate,
  EnvironmentContainers
);
@@clientName(
  EnvironmentContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(
  EnvironmentContainerOperationGroup.delete,
  EnvironmentContainers
);
@@clientLocation(
  EnvironmentContainerOperationGroup.list,
  EnvironmentContainers
);

@@clientLocation(EnvironmentVersions.get, "RegistryEnvironmentVersions");
@@clientLocation(
  EnvironmentVersions.createOrUpdate,
  "RegistryEnvironmentVersions"
);
@@clientName(EnvironmentVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentVersions.delete, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersions.list, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersionOperationGroup.get, EnvironmentVersions);
@@clientLocation(
  EnvironmentVersionOperationGroup.createOrUpdate,
  EnvironmentVersions
);
@@clientName(
  EnvironmentVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(EnvironmentVersionOperationGroup.delete, EnvironmentVersions);
@@clientLocation(EnvironmentVersionOperationGroup.list, EnvironmentVersions);

@@clientLocation(ModelContainers.get, "RegistryModelContainers");
@@clientLocation(ModelContainers.createOrUpdate, "RegistryModelContainers");
@@clientName(ModelContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(ModelContainers.delete, "RegistryModelContainers");
@@clientLocation(ModelContainers.list, "RegistryModelContainers");
@@clientLocation(ModelContainerOperationGroup.get, ModelContainers);
@@clientLocation(ModelContainerOperationGroup.createOrUpdate, ModelContainers);
@@clientName(
  ModelContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ModelContainerOperationGroup.delete, ModelContainers);
@@clientLocation(ModelContainerOperationGroup.list, ModelContainers);

@@clientLocation(ModelVersions.get, "RegistryModelVersions");
@@clientLocation(ModelVersions.createOrUpdate, "RegistryModelVersions");
@@clientName(ModelVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(ModelVersions.delete, "RegistryModelVersions");
@@clientLocation(ModelVersions.list, "RegistryModelVersions");
@@clientLocation(ModelVersionOperationGroup.get, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.createOrUpdate, ModelVersions);
@@clientName(
  ModelVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ModelVersionOperationGroup.delete, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.list, ModelVersions);

@@clientName(BatchEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(BatchEndpoints.update::parameters.properties, "body");

@@clientName(BatchDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(BatchDeployments.update::parameters.properties, "body");

@@clientName(DataContainers.createOrUpdate::parameters.resource, "body");

@@clientLocation(DataVersionBases.get, "DataVersions");
@@clientLocation(DataVersionBases.createOrUpdate, "DataVersions");
@@clientName(DataVersionBases.createOrUpdate::parameters.resource, "body");
@@clientLocation(DataVersionBases.delete, "DataVersions");
@@clientLocation(DataVersionBases.list, "DataVersions");

@@clientName(Datastores.createOrUpdate::parameters.resource, "body");

@@clientLocation(JobBases.get, "Jobs");
@@clientLocation(JobBases.createOrUpdate, "Jobs");
@@clientName(JobBases.createOrUpdate::parameters.resource, "body");
@@clientLocation(JobBases.delete, "Jobs");
@@clientLocation(JobBases.list, "Jobs");
@@clientLocation(JobBases.cancel, "Jobs");

@@clientName(LabelingJobs.createOrUpdate::parameters.resource, "body");

@@clientName(OnlineEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineEndpoints.update::parameters.properties, "body");

@@clientName(OnlineDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineDeployments.update::parameters.properties, "body");

@@clientName(Schedules.createOrUpdate::parameters.resource, "body");

@@clientName(Registries.createOrUpdate::parameters.resource, "body");
@@clientName(Registries.update::parameters.properties, "body");

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientLocation(VirtualMachineSizesOperationGroup.list, "VirtualMachineSizes");

@@clientLocation(QuotasOperationGroup.update, "Quotas");
@@clientLocation(QuotasOperationGroup.list, "Quotas");
