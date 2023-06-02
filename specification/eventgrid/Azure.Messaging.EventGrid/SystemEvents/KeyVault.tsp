@doc("Describes the schema of the Azure Key Vault events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid.KeyVault {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNewVersionCreated event.")
  model KeyVaultCertificateNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateNearExpiry event.")
  model KeyVaultCertificateNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.CertificateExpired event.")
  model KeyVaultCertificateExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNewVersionCreated event.")
  model KeyVaultKeyNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyNearExpiry event.")
  model KeyVaultKeyNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.KeyExpired event.")
  model KeyVaultKeyExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNewVersionCreated event.")
  model KeyVaultSecretNewVersionCreatedEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretNearExpiry event.")
  model KeyVaultSecretNearExpiryEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.SecretExpired event.")
  model KeyVaultSecretExpiredEventData {
    ...KeyVaultCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.KeyVault.VaultAccessPolicyChanged event.")
  model KeyVaultVaultAccessPolicyChangedEventData {
    ...KeyVaultCertificateBase;
  }

  alias KeyVaultCertificateBase = {
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The id of the object that triggered this event.")
    Id?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("Key vault name of the object that triggered this event.")
    VaultName?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The type of the object that triggered this event")
    ObjectType?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The name of the object that triggered this event")
    ObjectName?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The version of the object that triggered this event")
    Version?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("Not before date of the object that triggered this event")
    NBF?: float64;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The expiration date of the object that triggered this event")
    EXP?: float64;
  };
}
