import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNewVersionCreatedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNewVersionCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNearExpiryEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNearExpiryEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateExpiredEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateExpiredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNewVersionCreatedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNewVersionCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNearExpiryEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNearExpiryEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultKeyExpiredEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultKeyExpiredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNewVersionCreatedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNewVersionCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNearExpiryEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNearExpiryEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultSecretExpiredEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultSecretExpiredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.KeyVaultAccessPolicyChangedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.KeyVaultAccessPolicyChangedEventData,
  Access.public
);
//Enums

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNewVersionCreatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateNearExpiryEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultCertificateExpiredEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNewVersionCreatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultKeyNearExpiryEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultKeyExpiredEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNewVersionCreatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultSecretNearExpiryEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultSecretExpiredEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.KeyVaultAccessPolicyChangedEventData,
  "csharp"
);
