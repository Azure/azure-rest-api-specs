import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MobileNetwork;

@@clientName(QosPolicy.`5qi`, "fiveQi");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SimNameAndProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SimNameAndEncryptedProperties.properties);

@@clientName(DataNetworkConfiguration.`5qi`, "fiveQi");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DnnIpPair.ueIpAddress);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GlobalRanNodeId.plmnId);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GlobalRanNodeId.gNbId);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo5G.info);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo5GProperties.fivegGuti);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo5GProperties.connectionInfo);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Guti5G.plmn);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Guti5G.amfId);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeConnectionInfo5G.locationInfo);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeConnectionInfo5G.globalRanNodeId);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeLocationInfo.plmn);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeSessionInfo5G.snssai);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeSessionInfo5G.ueIpAddress);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeSessionInfo5G.ambr);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeQOSFlow.qfi);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeQOSFlow.fiveqi);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeQOSFlow.mbr);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeQOSFlow.gbr);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo4G.info);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo4GProperties.guti);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeInfo4GProperties.connectionInfo);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Guti4G.plmn);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Guti4G.mmeId);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeConnectionInfo4G.locationInfo);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeConnectionInfo4G.globalRanNodeId);
@@clientName(UeConnectionInfo4G.mmeS1apId, "mmeS1ApId");
@@clientName(UeConnectionInfo4G.enbS1apId, "enbS1ApId");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UeSessionInfo4G.ueIpAddress);

@@clientName(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AttachedDataNetworks.updateTags::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AttachedDataNetwork.properties);

@@clientName(DataNetworks.createOrUpdate::parameters.resource, "parameters");
@@clientName(DataNetworks.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DataNetwork.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiagnosticsPackage.properties);

@@clientName(MobileNetworks.createOrUpdate::parameters.resource, "parameters");
@@clientName(MobileNetworks.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MobileNetwork.properties);

@@clientName(SimGroups.createOrUpdate::parameters.resource, "parameters");
@@clientName(SimGroups.updateTags::parameters.properties, "parameters");
@@clientLocation(SimGroups.bulkUpload, Sims);
@@clientName(SimGroups.bulkUpload::parameters.body, "parameters");
@@clientLocation(SimGroups.bulkDelete, Sims);
@@clientName(SimGroups.bulkDelete::parameters.body, "parameters");
@@clientLocation(SimGroups.bulkUploadEncrypted, Sims);
@@clientName(SimGroups.bulkUploadEncrypted::parameters.body, "parameters");
@@clientLocation(SimGroups.move, Sims);
@@clientName(SimGroups.move::parameters.body, "parameters");
@@clientLocation(SimGroups.clone, Sims);
@@clientName(SimGroups.clone::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SimGroup.properties);

@@clientName(PacketCaptures.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PacketCapture.properties);

@@clientName(PacketCoreControlPlanes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PacketCoreControlPlanes.updateTags::parameters.properties,
  "parameters"
);
@@clientName(PacketCoreControlPlanes.collectDiagnosticsPackage::parameters.body,
  "parameters"
);
@@clientLocation(PacketCoreControlPlanes.list, "UeInformation");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PacketCoreControlPlane.properties);

@@clientLocation(RoutingInfoModels.get, "RoutingInfo");
@@clientLocation(RoutingInfoModels.list, "RoutingInfo");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RoutingInfoModel.properties);

@@clientLocation(PacketCoreControlPlaneVersionOperationGroup.getBySubscription,
  PacketCoreControlPlaneVersions
);
@@clientLocation(PacketCoreControlPlaneVersionOperationGroup.listBySubscription,
  PacketCoreControlPlaneVersions
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PacketCoreControlPlaneVersion.properties);

@@clientName(PacketCoreDataPlanes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PacketCoreDataPlanes.updateTags::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PacketCoreDataPlane.properties);

@@clientName(Services.createOrUpdate::parameters.resource, "parameters");
@@clientName(Services.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Service.properties);

@@clientName(Sims.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Sim.properties);

@@clientName(SimPolicies.createOrUpdate::parameters.resource, "parameters");
@@clientName(SimPolicies.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SimPolicy.properties);

@@clientName(Sites.createOrUpdate::parameters.resource, "parameters");
@@clientName(Sites.updateTags::parameters.properties, "parameters");
@@clientName(Sites.deletePacketCore::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Site.properties);

@@clientName(Slices.createOrUpdate::parameters.resource, "parameters");
@@clientName(Slices.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Slice.properties);

@@clientLocation(ExtendedUeInfos.get, "ExtendedUeInformation");
