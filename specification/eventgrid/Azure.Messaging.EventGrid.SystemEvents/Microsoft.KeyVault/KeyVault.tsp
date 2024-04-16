/** Describes the schema of the Azure Key Vault events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNewVersionCreated event. */
  model KeyVaultCertificateNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNearExpiry event. */
  model KeyVaultCertificateNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateExpired event. */
  model KeyVaultCertificateExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNewVersionCreated event. */
  model KeyVaultKeyNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNearExpiry event. */
  model KeyVaultKeyNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyExpired event. */
  model KeyVaultKeyExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNewVersionCreated event. */
  model KeyVaultSecretNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNearExpiry event. */
  model KeyVaultSecretNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretExpired event. */
  model KeyVaultSecretExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.VaultAccessPolicyChanged event. */
  model KeyVaultVaultAccessPolicyChangedEventData {
    ...KeyVaultCertificateBase;
  }

  alias KeyVaultCertificateBase = {
    /** The id of the object that triggered this event. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    Id?: string;

    /** Key vault name of the object that triggered this event. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    VaultName?: string;

    /** The type of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    ObjectType?: string;

    /** The name of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    ObjectName?: string;

    /** The version of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    Version?: string;

    /** Not before date of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    NBF?: float32;

    /** The expiration date of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    EXP?: float32;
  };
}
