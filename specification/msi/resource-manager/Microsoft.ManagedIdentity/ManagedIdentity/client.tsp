import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

@@clientName(Microsoft.ManagedIdentity,
  "ManagedServiceIdentityClient",
  "javascript, java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Identity.properties,
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SystemAssignedIdentity.properties,
  "java"
);

@@clientName(Identity, "UserAssignedIdentity", "csharp");
@@clientName(FederatedIdentityCredentialProperties.issuer, "IssuerUri", "csharp");
@@alternateType(SystemAssignedIdentityProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(UserAssignedIdentityProperties.tenantId, Azure.Core.uuid, "csharp");

// Fix: SystemAssignedIdentityData must inherit TrackedResourceData (matches pre-migration baseline)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SystemAssignedIdentity,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// Fix: UserAssignedIdentityPatch must inherit TrackedResourceData (matches pre-migration baseline)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IdentityUpdate,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// Fix: Flatten SystemAssignedIdentity.properties for C# (back-compatible.tsp only scopes to "autorest")
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SystemAssignedIdentity.properties, "csharp");

// Fix: Flatten Identity (UserAssignedIdentity) .properties for C# (back-compatible.tsp only scopes to "autorest")
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Identity.properties, "csharp");

// Fix: clientSecretUrl must produce Uri type (pre-migration baseline had System.Uri ClientSecretUri)
@@alternateType(SystemAssignedIdentityProperties.clientSecretUrl, url, "csharp");

// Fix: SystemAssignedIdentity is read-only (GET only) so generator marks constructor internal.
// Add Input usage to restore public ctor and virtual JsonModelWriteCore (needed for ApiCompat).
@@usage(SystemAssignedIdentity, Usage.input | Usage.output, "csharp");
