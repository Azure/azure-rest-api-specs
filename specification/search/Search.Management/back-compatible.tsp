import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Search;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SearchServiceUpdate.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SearchService.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "sharedPrivateLinkResource"
);

@@clientLocation(ServicesOperationGroup.checkNameAvailability, "Services");

@@clientLocation(UsagesOperationGroup.listBySubscription, "Usages");
