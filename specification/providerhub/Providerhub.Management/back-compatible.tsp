import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

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

@@clientLocation(OperationsPutContents.listByProviderRegistration, Operations);
@@clientLocation(OperationsPutContents.createOrUpdate, Operations);
@@clientName(OperationsPutContents.createOrUpdate::parameters.resource,
  "OperationsPutContent"
);
@@clientLocation(OperationsPutContents.delete, Operations);

@@clientLocation(SkuResources.get, Skus);
@@clientLocation(SkuResources.createOrUpdate, Skus);
@@clientName(SkuResources.createOrUpdate::parameters.resource, "properties");
@@clientLocation(SkuResources.delete, Skus);
@@clientLocation(SkuResources.listByResourceTypeRegistrations, Skus);
@@clientName(Skus.createOrUpdateNestedResourceTypeFirst::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperationGroup.getNestedResourceTypeSecond, "Skus");
@@clientLocation(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond,
  "Skus"
);
@@clientName(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperationGroup.deleteNestedResourceTypeSecond,
  "Skus"
);
@@clientLocation(SkuResourceOperationGroup.listByResourceTypeRegistrationsNestedResourceTypeSecond,
  "Skus"
);
@@clientLocation(SkuResourceOperationGroup.getNestedResourceTypeSecond, Skus);
@@clientLocation(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond,
  Skus
);
@@clientName(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "properties"
);
@@clientLocation(SkuResourceOperationGroup.deleteNestedResourceTypeSecond,
  Skus
);
@@clientLocation(SkuResourceOperationGroup.listByResourceTypeRegistrationsNestedResourceTypeSecond,
  Skus
);

@@clientName(AuthorizedApplications.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(ProviderMonitorSettings.create::parameters.resource, "properties");

@@clientLocation(SkuResourceOperationGroupThird.listByResourceTypeRegistrationsNestedResourceTypeThird,
  Skus
);
@@clientLocation(SkuResourceOperationGroupThird.deleteNestedResourceTypeThird,
  Skus
);
@@clientLocation(SkuResourceOperationGroupThird.createOrUpdateNestedResourceTypeThird,
  Skus
);
@@clientLocation(SkuResourceOperationGroupThird.getNestedResourceTypeThird,
  Skus
);

@@clientName(SkuResourceOperationGroupThird.createOrUpdateNestedResourceTypeThird::parameters.resource,
  "properties"
);
