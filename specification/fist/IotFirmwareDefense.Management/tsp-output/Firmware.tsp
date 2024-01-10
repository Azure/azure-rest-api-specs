import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.IoTFirmwareDefense;
@doc("Firmware definition")
@parentResource(Workspace)
model Firmware is ProxyResource<FirmwareProperties> {
  @doc("The id of the firmware.")
  @key("firmwareId")
  @segment("firmwares")
  name: string;
}

@armResourceOperations
@projectedName("client", "Firmware")
interface FirmwareOperationGroup {
  @doc("Get firmware.")
  get is ArmResourceRead<Firmware>;

  @doc("The operation to create a firmware.")
  create is ArmResourceCreateOrReplaceSync<Firmware>;

  @doc("The operation to update firmware.")
  update is ArmCustomPatchSync<Firmware, FirmwareUpdateDefinition>;

  @doc("The operation to delete a firmware.")
  delete is ArmResourceDeleteSync<Firmware>;

  @doc("Lists all of firmwares inside a workspace.")
  listByWorkspace is ArmResourceListByParent<Firmware>;

  @doc("The operation to a url for file download.")
  generateDownloadUrl is ArmResourceActionSync<Firmware, void, UrlToken>;

  @doc("The operation to a url for tar file download.")
  generateFilesystemDownloadUrl is ArmResourceActionSync<
    Firmware,
    void,
    UrlToken
  >;

  @doc("The operation to get a scan summary.")
  generateSummary is ArmResourceActionSync<Firmware, void, FirmwareSummary>;

  @doc("The operation to list all components result for a firmware.")
  listGenerateComponentList is ArmResourceActionSync<
    Firmware,
    void,
    ComponentList
  >;

  @doc("The operation to get component details for a firmware.")
  generateComponentDetails is ArmResourceActionSync<Firmware, void, Component>;

  @doc("The operation to list all binary hardening result for a firmware.")
  listGenerateBinaryHardeningList is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardeningList
  >;

  @doc("The operation to list the binary hardening summary percentages for a firmware.")
  generateBinaryHardeningSummary is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardeningSummary
  >;

  @doc("The operation to get binary hardening details for a firmware.")
  generateBinaryHardeningDetails is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardening
  >;

  @doc("The operation to list all password hashes for a firmware.")
  listGeneratePasswordHashList is ArmResourceActionSync<
    Firmware,
    void,
    PasswordHashList
  >;

  @doc("The operation to list all cve results for a firmware.")
  listGenerateCveList is ArmResourceActionSync<Firmware, void, CveList>;

  @doc("The operation to provide a high level summary of the CVEs reported for the firmware image.")
  generateCveSummary is ArmResourceActionSync<Firmware, void, CveSummary>;

  @doc("The operation to provide a high level summary of the discovered cryptographic certificates reported for the firmware image.")
  generateCryptoCertificateSummary is ArmResourceActionSync<
    Firmware,
    void,
    CryptoCertificateSummary
  >;

  @doc("The operation to provide a high level summary of the discovered cryptographic keys reported for the firmware image.")
  generateCryptoKeySummary is ArmResourceActionSync<
    Firmware,
    void,
    CryptoKeySummary
  >;

  @doc("The operation to list all crypto certificates for a firmware.")
  listGenerateCryptoCertificateList is ArmResourceActionSync<
    Firmware,
    void,
    CryptoCertificateList
  >;

  @doc("The operation to list all crypto keys for a firmware.")
  listGenerateCryptoKeyList is ArmResourceActionSync<
    Firmware,
    void,
    CryptoKeyList
  >;
}
