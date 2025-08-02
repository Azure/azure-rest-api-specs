import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Storage.Blob;

@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride"
);
@@clientName(ContainerProperties.immutableStorageWithVersioningEnabled,
  "IsImmutableStorageWithVersioningEnabled"
);
@@clientName(BlobPropertiesInternal.expiryTime, "ExpiresOn");
@@clientName(BlobPropertiesInternal.sealed, "IsSealed");
@@clientName(BlobPropertiesInternal.immutabilityPolicyUntilDate,
  "ImmutabilityPolicyExpiresOn"
);
@@clientName(PremiumPageBlobAccessTierOptional.accessTier, "tier");
