import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperationsContentProperties.contents
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceManagementAction.resources
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperationsContent.properties
);

@@clientName(CustomRollouts.createOrUpdate::parameters.resource, "properties");

@@clientName(ProviderRegistrations.createOrUpdate::parameters.resource,
  "properties"
);
@@clientLocation(ProviderRegistrations.generateManifest, "");
@@clientLocation(ProviderRegistrations.checkinManifest, "");
@@clientName(ProviderRegistrations.checkinManifest::parameters.body,
  "checkinManifestParams"
);
@@clientLocation(ProviderRegistrations.deleteResources, "ResourceActions");
@@clientName(ProviderRegistrations.deleteResources::parameters.body,
  "properties"
);
@@clientLocation(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest,
  NewRegionFrontloadRelease
);
@@clientName(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest,
  "GenerateManifest"
);
@@clientName(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest::parameters.body,
  "properties"
);

@@clientName(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(DefaultRollouts.createOrUpdate::parameters.resource, "properties");
@@clientName(NewRegionFrontloadRelease.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(NotificationRegistrations.createOrUpdate::parameters.resource,
  "properties"
);

@@clientLocation(OperationsPutContents.listByProviderRegistration,
  "Operations"
);
@@clientLocation(OperationsPutContents.createOrUpdate, "Operations");
@@clientName(OperationsPutContents.createOrUpdate::parameters.resource,
  "OperationsPutContent"
);
@@clientLocation(OperationsPutContents.delete, "Operations");

@@clientLocation(SkuResources.get, Skus);
@@clientLocation(SkuResources.createOrUpdate, Skus);
@@clientName(SkuResources.createOrUpdate::parameters.resource, "properties");
@@clientLocation(SkuResources.delete, Skus);
@@clientLocation(SkuResources.listByResourceTypeRegistrations, Skus);
@@clientName(Skus.createOrUpdateNestedResourceTypeFirst::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperations.getNestedResourceTypeSecond, Skus);
@@clientLocation(SkuResourceOperations.createOrUpdateNestedResourceTypeSecond,
  Skus
);
@@clientName(SkuResourceOperations.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperations.deleteNestedResourceTypeSecond, Skus);
@@clientLocation(SkuResourceOperations.listByResourceTypeRegistrationsNestedResourceTypeSecond,
  Skus
);
@@clientLocation(SkuResourceOperationGroup.getNestedResourceTypeThird, Skus);
@@clientLocation(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeThird,
  Skus
);
@@clientName(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeThird::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperationGroup.deleteNestedResourceTypeThird, Skus);
@@clientLocation(SkuResourceOperationGroup.listByResourceTypeRegistrationsNestedResourceTypeThird,
  Skus
);

@@clientName(AuthorizedApplications.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(ProviderMonitorSettings.create::parameters.resource, "properties");
