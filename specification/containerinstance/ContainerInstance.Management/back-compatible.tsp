import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerInstance;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ListResultContainerGroupProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Container.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InitContainerDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeploymentExtensionSpec.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerGroupProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NGroupPatch.properties);

@@clientName(ContainerGroups.createOrUpdate::parameters.resource,
  "containerGroup"
);
@@clientName(ContainerGroups.update::parameters.properties, "Resource");
@@clientLocation(ContainerGroups.listLogs, "Containers");
@@clientLocation(ContainerGroups.executeCommand, "Containers");
@@clientName(ContainerGroups.executeCommand::parameters.body,
  "containerExecRequest"
);
@@clientLocation(ContainerGroups.attach, "Containers");

@@clientName(NGroups.createOrUpdate::parameters.resource, "NGroup");
@@clientName(NGroups.update::parameters.properties, "NGroup");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NGroup.properties);

@@clientName(ContainerGroupProfiles.createOrUpdate::parameters.resource,
  "ContainerGroupProfile"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerGroupProfile.properties);

@@clientLocation(ContainerGroupsOperationGroup.list, ContainerGroups);
@@clientLocation(ContainerGroupsOperationGroup.listByResourceGroup,
  ContainerGroups
);

@@clientLocation(LocationOperationGroup.listUsage, "Location");
@@clientLocation(LocationOperationGroup.listCachedImages, "Location");
@@clientLocation(LocationOperationGroup.listCapabilities, "Location");

@@clientLocation(SubnetServiceAssociationLinkOperationGroup.delete,
  "SubnetServiceAssociationLink"
);
