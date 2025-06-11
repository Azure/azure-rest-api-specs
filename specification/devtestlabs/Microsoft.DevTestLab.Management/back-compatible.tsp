import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevTestLab;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabVirtualMachineCreationParameter.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduleCreationParameter.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cost.properties);

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
@@clientName(Labs.evaluatePolicies::parameters.body, "evaluatePoliciesRequest");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Lab.properties);

@@clientName(Schedules.createOrUpdate::parameters.resource, "schedule");
@@clientName(Schedules.update::parameters.properties, "schedule");
@@clientName(Schedules.retarget::parameters.body, "retargetScheduleProperties");
@@clientName(ServiceFabricSchedules.createOrUpdate::parameters.resource,
  "schedule"
);
@@clientName(ServiceFabricSchedules.update::parameters.properties, "schedule");
@@clientName(VirtualMachineSchedules.createOrUpdate::parameters.resource,
  "schedule"
);
@@clientName(VirtualMachineSchedules.update::parameters.properties, "schedule");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Schedule.properties);

@@clientName(ArtifactSources.createOrUpdate::parameters.resource,
  "artifactSource"
);
@@clientName(ArtifactSources.update::parameters.properties, "artifactSource");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArtifactSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArmTemplate.properties);

@@clientName(Artifacts.generateArmTemplate::parameters.body,
  "generateArmTemplateRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Artifact.properties);

@@clientName(LabCosts.createOrUpdate::parameters.resource, "labCost");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabCost.properties);

@@clientName(CustomImages.createOrUpdate::parameters.resource, "customImage");
@@clientName(CustomImages.update::parameters.properties, "customImage");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomImage.properties);

@@clientName(Formulas.createOrUpdate::parameters.resource, "formula");
@@clientName(Formulas.update::parameters.properties, "formula");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Formula.properties);

@@clientName(NotificationChannels.createOrUpdate::parameters.resource,
  "notificationChannel"
);
@@clientName(NotificationChannels.update::parameters.properties,
  "notificationChannel"
);
@@clientName(NotificationChannels.notify::parameters.body, "notifyParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NotificationChannel.properties);

@@clientName(Policies.createOrUpdate::parameters.resource, "policy");
@@clientName(Policies.update::parameters.properties, "policy");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Policy.properties);

@@clientName(LabSecrets.createOrUpdate::parameters.resource, "labSecret");
@@clientName(LabSecrets.update::parameters.properties, "secret");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabSecret.properties);

@@clientName(ServiceRunners.createOrUpdate::parameters.resource,
  "serviceRunner"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceRunner.properties);

@@clientName(SharedGalleries.createOrUpdate::parameters.resource,
  "sharedGallery"
);
@@clientName(SharedGalleries.update::parameters.properties, "sharedGallery");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedGallery.properties);

@@clientName(SharedImages.createOrUpdate::parameters.resource, "sharedImage");
@@clientName(SharedImages.update::parameters.properties, "sharedImage");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedImage.properties);

@@clientName(LabUsers.createOrUpdate::parameters.resource, "user");
@@clientName(LabUsers.update::parameters.properties, "user");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabUser.properties);

@@clientName(Disks.createOrUpdate::parameters.resource, "disk");
@@clientName(Disks.update::parameters.properties, "disk");
@@clientName(Disks.attach::parameters.body, "attachDiskProperties");
@@clientName(Disks.detach::parameters.body, "detachDiskProperties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Disk.properties);

@@clientName(DtlEnvironments.createOrUpdate::parameters.resource,
  "dtlEnvironment"
);
@@clientName(DtlEnvironments.update::parameters.properties, "dtlEnvironment");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DtlEnvironment.properties);

@@clientName(Secrets.createOrUpdate::parameters.resource, "secret");
@@clientName(Secrets.update::parameters.properties, "secret");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Secret.properties);

@@clientName(ServiceFabrics.createOrUpdate::parameters.resource,
  "serviceFabric"
);
@@clientName(ServiceFabrics.update::parameters.properties, "serviceFabric");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceFabric.properties);

@@clientName(LabVirtualMachines.createOrUpdate::parameters.resource,
  "labVirtualMachine"
);
@@clientName(LabVirtualMachines.update::parameters.properties,
  "labVirtualMachine"
);
@@clientName(LabVirtualMachines.addDataDisk::parameters.body,
  "dataDiskProperties"
);
@@clientName(LabVirtualMachines.applyArtifacts::parameters.body,
  "applyArtifactsRequest"
);
@@clientName(LabVirtualMachines.changeSecurityProfile::parameters.body,
  "changeSecurityProfileProperties"
);
@@clientName(LabVirtualMachines.detachDataDisk::parameters.body,
  "detachDataDiskProperties"
);
@@clientName(LabVirtualMachines.resize::parameters.body,
  "resizeLabVirtualMachineProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabVirtualMachine.properties);

@@clientName(VirtualNetworks.createOrUpdate::parameters.resource,
  "virtualNetwork"
);
@@clientName(VirtualNetworks.update::parameters.properties, "virtualNetwork");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetwork.properties);

@@clientName(BastionHosts.createOrUpdate::parameters.resource, "bastionHost");
@@clientName(BastionHosts.update::parameters.properties, "bastionHost");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BastionHost.properties);
