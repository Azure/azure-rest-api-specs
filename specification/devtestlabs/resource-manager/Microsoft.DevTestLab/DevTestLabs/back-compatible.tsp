import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevTestLab;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LabVirtualMachineCreationParameter.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScheduleCreationParameter.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImage.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicableSchedule.properties
);

@@clientName(Labs.createOrUpdate::parameters.resource, "lab");
@@clientName(Labs.update::parameters.properties, "lab");
@@clientName(Labs.createEnvironment::parameters.body,
  "labVirtualMachineCreationParameter"
);
@@clientName(Labs.exportResourceUsage::parameters.body,
  "exportResourceUsageParameters"
);
@@clientName(Labs.generateUploadUri::parameters.body,
  "generateUploadUriParameter"
);
@@clientName(Labs.importVirtualMachine::parameters.body,
  "importLabVirtualMachineRequest"
);
@@clientName(PolicySets.evaluatePolicies::parameters.body,
  "evaluatePoliciesRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Lab.properties);

@@clientName(GlobalSchedules.createOrUpdate::parameters.resource, "schedule");
@@clientName(GlobalSchedules.update::parameters.properties, "schedule");
@@clientName(GlobalSchedules.retarget::parameters.body,
  "retargetScheduleProperties"
);
@@clientName(Schedules.createOrUpdate::parameters.resource, "schedule");
@@clientName(Schedules.update::parameters.properties, "schedule");
@@clientName(ServiceFabricSchedules.createOrUpdate::parameters.resource,
  "schedule"
);
@@clientName(ServiceFabricSchedules.update::parameters.properties, "schedule");
@@clientName(VirtualMachineSchedules.createOrUpdate::parameters.resource,
  "schedule"
);
@@clientName(VirtualMachineSchedules.update::parameters.properties, "schedule");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Schedule.properties);

@@clientName(ArtifactSources.createOrUpdate::parameters.resource,
  "artifactSource"
);
@@clientName(ArtifactSources.update::parameters.properties, "artifactSource");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArtifactSource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArmTemplate.properties);

@@clientName(Artifacts.generateArmTemplate::parameters.body,
  "generateArmTemplateRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Artifact.properties);

@@clientName(Costs.createOrUpdate::parameters.resource, "labCost");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LabCost.properties);

@@clientName(CustomImages.createOrUpdate::parameters.resource, "customImage");
@@clientName(CustomImages.update::parameters.properties, "customImage");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomImage.properties);

@@clientName(Formulas.createOrUpdate::parameters.resource, "formula");
@@clientName(Formulas.update::parameters.properties, "formula");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Formula.properties);

@@clientName(NotificationChannels.createOrUpdate::parameters.resource,
  "notificationChannel"
);
@@clientName(NotificationChannels.update::parameters.properties,
  "notificationChannel"
);
@@clientName(NotificationChannels.notify::parameters.body, "notifyParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NotificationChannel.properties
);

@@clientName(Policies.createOrUpdate::parameters.resource, "policy");
@@clientName(Policies.update::parameters.properties, "policy");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Policy.properties);

@@clientName(ServiceRunners.createOrUpdate::parameters.resource,
  "serviceRunner"
);

@@clientName(Users.createOrUpdate::parameters.resource, "user");
@@clientName(Users.update::parameters.properties, "user");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(User.properties);

@@clientName(Disks.createOrUpdate::parameters.resource, "disk");
@@clientName(Disks.update::parameters.properties, "disk");
@@clientName(Disks.attach::parameters.body, "attachDiskProperties");
@@clientName(Disks.detach::parameters.body, "detachDiskProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Disk.properties);

@@clientName(Environments.createOrUpdate::parameters.resource,
  "dtlEnvironment"
);
@@clientName(Environments.update::parameters.properties, "dtlEnvironment");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DtlEnvironment.properties);

@@clientName(Secrets.createOrUpdate::parameters.resource, "secret");
@@clientName(Secrets.update::parameters.properties, "secret");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Secret.properties);

@@clientName(ServiceFabrics.createOrUpdate::parameters.resource,
  "serviceFabric"
);
@@clientName(ServiceFabrics.update::parameters.properties, "serviceFabric");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServiceFabric.properties);

@@clientName(VirtualMachines.createOrUpdate::parameters.resource,
  "labVirtualMachine"
);
@@clientName(VirtualMachines.update::parameters.properties,
  "labVirtualMachine"
);
@@clientName(VirtualMachines.addDataDisk::parameters.body,
  "dataDiskProperties"
);
@@clientName(VirtualMachines.applyArtifacts::parameters.body,
  "applyArtifactsRequest"
);
@@clientName(VirtualMachines.detachDataDisk::parameters.body,
  "detachDataDiskProperties"
);
@@clientName(VirtualMachines.resize::parameters.body,
  "resizeLabVirtualMachineProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LabVirtualMachine.properties
);

@@clientName(VirtualNetworks.createOrUpdate::parameters.resource,
  "virtualNetwork"
);
@@clientName(VirtualNetworks.update::parameters.properties, "virtualNetwork");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualNetwork.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualNetworks.get,
  "virtualnetworkName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualNetworks.createOrUpdate,
  "virtualnetworkName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualNetworks.update,
  "virtualnetworkName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualNetworks.delete,
  "virtualnetworkName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Users.get,
  "userName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Users.createOrUpdate,
  "userName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Users.update,
  "userName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Users.delete,
  "userName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceRunners.get,
  "serviceRunnerName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceRunners.createOrUpdate,
  "serviceRunnerName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceRunners.delete,
  "serviceRunnerName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.get,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.createOrUpdate,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.update,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.delete,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.listApplicableSchedules,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.start,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ServiceFabrics.stop,
  "serviceFabricName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Secrets.get,
  "secretName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Secrets.createOrUpdate,
  "secretName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Secrets.update,
  "secretName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Secrets.delete,
  "secretName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(NotificationChannels.get,
  "notificationChannelName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(NotificationChannels.createOrUpdate,
  "notificationChannelName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(NotificationChannels.update,
  "notificationChannelName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(NotificationChannels.delete,
  "notificationChannelName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(NotificationChannels.notify,
  "notificationChannelName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.get,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.createOrUpdate,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.update,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.delete,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.addDataDisk,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.applyArtifacts,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.claim,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.detachDataDisk,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.getRdpFileContents,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.listApplicableSchedules,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.redeploy,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.resize,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.restart,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.start,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.stop,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.transferDisks,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(VirtualMachines.unClaim,
  "virtualMachineName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Costs.get,
  "costName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Costs.createOrUpdate,
  "costName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Formulas.get,
  "formulaName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Formulas.createOrUpdate,
  "formulaName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Formulas.update,
  "formulaName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Formulas.delete,
  "formulaName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Environments.get,
  "environmentName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Environments.createOrUpdate,
  "environmentName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Environments.update,
  "environmentName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Environments.delete,
  "environmentName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.get,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.createOrUpdate,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.update,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.delete,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.attach,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Disks.detach,
  "diskName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ArtifactSources.get,
  "artifactSourceName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ArtifactSources.createOrUpdate,
  "artifactSourceName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ArtifactSources.update,
  "artifactSourceName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ArtifactSources.delete,
  "artifactSourceName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Artifacts.get,
  "artifactName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Artifacts.generateArmTemplate,
  "artifactName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(ArmTemplates.get,
  "armTemplateName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.get, "labName", "name");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.createOrUpdate,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.update,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.delete,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.claimAnyVm,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.createEnvironment,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.exportResourceUsage,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.generateUploadUri,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.importVirtualMachine,
  "labName",
  "name"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ResourceManager.Legacy.renamePathParameter(Labs.listVhds,
  "labName",
  "name"
);
