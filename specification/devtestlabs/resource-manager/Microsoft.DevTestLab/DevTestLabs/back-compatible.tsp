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
