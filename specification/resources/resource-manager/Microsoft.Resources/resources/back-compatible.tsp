import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientLocation(SpecificResources.checkExistence, "Resources");
@@clientLocation(SpecificResources.delete, "Resources");
@@clientLocation(SpecificResources.get, "Resources");
@@clientLocation(SpecificResources.createOrUpdate, "Resources");
@@clientLocation(SpecificResources.update, "Resources");

@@clientName(ResourceGroups.createOrUpdate::parameters.resource, "parameters");
@@clientName(ResourceGroups.update::parameters.properties, "parameters");
@@clientLocation(ResourceGroups.listByResourceGroup, "Resources");
@@clientLocation(ResourceGroups.moveResources, "Resources");
@@clientName(ResourceGroups.moveResources::parameters.body, "parameters");
@@clientLocation(ResourceGroups.validateMoveResources, "Resources");
@@clientName(ResourceGroups.validateMoveResources::parameters.body,
  "parameters"
);
@@clientName(ResourceGroups.exportTemplate::parameters.body, "parameters");

@@clientName(Resources.createOrUpdateById::parameters.resource, "parameters");
@@clientName(Resources.updateById::parameters.properties, "parameters");
@@clientName(SpecificResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SpecificResources.update::parameters.properties, "parameters");

// @@clientLocation(TagsResources.getAtScope, "Tags");
// @@clientLocation(TagsResources.createOrUpdateAtScope, "Tags");
@@clientName(TagsResources.createOrUpdateAtScope::parameters.resource,
  "parameters"
);
// @@clientLocation(TagsResources.updateAtScope, "Tags");
@@clientName(TagsResources.updateAtScope::parameters.properties, "parameters");
// @@clientLocation(TagsResources.deleteAtScope, "Tags");

@@clientLocation(ProvidersOperationGroup.listAtTenantScope, "Providers");
@@clientLocation(ProvidersOperationGroup.unregister, "Providers");
@@clientLocation(ProvidersOperationGroup.registerAtManagementGroupScope,
  "Providers"
);
@@clientLocation(ProvidersOperationGroup.providerPermissions, "Providers");
@@clientLocation(ProvidersOperationGroup.register, "Providers");
@@clientLocation(ProvidersOperationGroup.list, "Providers");
@@clientLocation(ProvidersOperationGroup.get, "Providers");
@@clientLocation(ProvidersOperationGroup.getAtTenantScope, "Providers");

@@clientLocation(ProviderResourceTypesOperationGroup.list,
  "ProviderResourceTypes"
);

@@clientLocation(ResourcesOperationGroup.list, "Resources");

@@clientLocation(TagsOperationGroup.deleteValue, "Tags");
@@clientLocation(TagsOperationGroup.createOrUpdateValue, "Tags");
@@clientLocation(TagsOperationGroup.createOrUpdate, "Tags");
@@clientLocation(TagsOperationGroup.delete, "Tags");
@@clientLocation(TagsOperationGroup.list, "Tags");
