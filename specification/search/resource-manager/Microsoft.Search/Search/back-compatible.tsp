import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Search;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SearchServiceUpdate.properties
);

@@clientName(CheckNameAvailabilityOutput.nameAvailable, "IsNameAvailable");

@@clientLocation(SearchServices.get, "Services");
@@clientLocation(SearchServices.createOrUpdate, "Services");
@@clientName(SearchServices.createOrUpdate::parameters.resource, "service");
@@clientLocation(SearchServices.update, "Services");
@@clientName(SearchServices.update::parameters.properties, "service");
@@clientLocation(SearchServices.delete, "Services");
@@clientLocation(SearchServices.listByResourceGroup, "Services");
@@clientLocation(SearchServices.listBySubscription, "Services");
@@clientLocation(SearchServices.adminKeysGet, "AdminKeys");
@@clientName(SearchServices.adminKeysGet, "Get");
@@clientLocation(SearchServices.regenerate, "AdminKeys");
@@clientLocation(SearchServices.create, "QueryKeys");
@@clientLocation(SearchServices.listBySearchService, "QueryKeys");
@@clientLocation(SearchServices.queryKeysDelete, "QueryKeys");
@@clientName(SearchServices.queryKeysDelete, "Delete");
@@clientLocation(SearchServices.upgrade, "Services");
@@clientLocation(SearchServices.listSupported, "PrivateLinkResources");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SearchService.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "sharedPrivateLinkResource"
);

@@clientLocation(ServicesOperationGroup.checkNameAvailability, "Services");

@@clientLocation(UsagesOperationGroup.listBySubscription, "Usages");
@@clientName(ServicesOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);

@@minLength(Azure.ResourceManager.CommonTypes.NspConfigurationNameParameter.networkSecurityPerimeterConfigurationName,
  38
);
@@maxLength(Azure.ResourceManager.CommonTypes.NspConfigurationNameParameter.networkSecurityPerimeterConfigurationName,
  100
);
@@pattern(Azure.ResourceManager.CommonTypes.NspConfigurationNameParameter.networkSecurityPerimeterConfigurationName,
  "^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}\\.[a-z][a-z0-9]*$"
);
@@doc(Azure.ResourceManager.CommonTypes.NspConfigurationNameParameter.networkSecurityPerimeterConfigurationName,
  "The network security perimeter configuration name."
);
