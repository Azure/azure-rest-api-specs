import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Key Vault events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNewVersionCreated event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultCertificateNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNearExpiry event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultCertificateNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateExpired event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultCertificateExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNewVersionCreated event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultKeyNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNearExpiry event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultKeyNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyExpired event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultKeyExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNewVersionCreated event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultSecretNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNearExpiry event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultSecretNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretExpired event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultSecretExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.VaultAccessPolicyChanged event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model KeyVaultAccessPolicyChangedEventData {
    ...KeyVaultCertificateBase;
  }

  alias KeyVaultCertificateBase = {
    /** The id of the object that triggered this event. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    Id: string;

    /** Key vault name of the object that triggered this event. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    VaultName: string;

    /** The type of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    ObjectType: string;

    /** The name of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    ObjectName: string;

    /** The version of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    Version: string;

    /** Not before date of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @madeRequired(ServiceApiVersions.v2024_01_01)
    NBF: float32;

    /** The expiration date of the object that triggered this event */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @madeRequired(ServiceApiVersions.v2024_01_01)
    EXP: float32;
  };
}
