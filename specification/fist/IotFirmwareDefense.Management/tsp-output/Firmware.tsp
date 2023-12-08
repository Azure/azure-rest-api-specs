import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FirmwareWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotFirmwareDefense;
@doc("Firmware definition")
@parentResource(FirmwareWorkspace)
model Firmware is ProxyResource<FirmwareProperties> {
  @doc("The id of the firmware.")
  @path
  @key("firmwareId")
  @segment("firmwares")
  name: string;
}

@armResourceOperations
interface Firmware {
  @doc("Get firmware.")
  get is ArmResourceRead<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to create a firmware.")
  create is ArmResourceCreateOrReplaceSync<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to update firmware.")
  update is ArmResourcePatchSync<
    Firmware,
    FirmwareProperties,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to delete a firmware.")
  delete is ArmResourceDeleteSync<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("Lists all of firmwares inside a workspace.")
  listByWorkspace is ArmResourceListByParent<Firmware>;
  @doc("The operation to a url for file download.")
  generateDownloadUrl is ArmResourceActionSync<
    Firmware,
    {},
    UrlToken,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to a url for tar file download.")
  generateFilesystemDownloadUrl is ArmResourceActionSync<
    Firmware,
    {},
    UrlToken,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to get a scan summary.")
  generateSummary is ArmResourceActionSync<
    Firmware,
    {},
    FirmwareSummary,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all components result for a firmware.")
  listGenerateComponentList is ArmResourceActionSync<
    Firmware,
    {},
    ComponentList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to get component details for a firmware.")
  generateComponentDetails is ArmResourceActionSync<
    Firmware,
    {},
    Component,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all binary hardening result for a firmware.")
  listGenerateBinaryHardeningList is ArmResourceActionSync<
    Firmware,
    {},
    BinaryHardeningList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list the binary hardening summary percentages for a firmware.")
  generateBinaryHardeningSummary is ArmResourceActionSync<
    Firmware,
    {},
    BinaryHardeningSummary,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to get binary hardening details for a firmware.")
  generateBinaryHardeningDetails is ArmResourceActionSync<
    Firmware,
    {},
    BinaryHardening,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all password hashes for a firmware.")
  listGeneratePasswordHashList is ArmResourceActionSync<
    Firmware,
    {},
    PasswordHashList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all cve results for a firmware.")
  listGenerateCveList is ArmResourceActionSync<
    Firmware,
    {},
    CveList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to provide a high level summary of the CVEs reported for the firmware image.")
  generateCveSummary is ArmResourceActionSync<
    Firmware,
    {},
    CveSummary,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to provide a high level summary of the discovered cryptographic certificates reported for the firmware image.")
  generateCryptoCertificateSummary is ArmResourceActionSync<
    Firmware,
    {},
    CryptoCertificateSummary,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to provide a high level summary of the discovered cryptographic keys reported for the firmware image.")
  generateCryptoKeySummary is ArmResourceActionSync<
    Firmware,
    {},
    CryptoKeySummary,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all crypto certificates for a firmware.")
  listGenerateCryptoCertificateList is ArmResourceActionSync<
    Firmware,
    {},
    CryptoCertificateList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
  @doc("The operation to list all crypto keys for a firmware.")
  listGenerateCryptoKeyList is ArmResourceActionSync<
    Firmware,
    {},
    CryptoKeyList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
}
