import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTFirmwareDefense;
@doc("Firmware definition")
@parentResource(Workspace)
model Firmware is ProxyResource<FirmwareProperties> {
  @doc("The id of the firmware.")
  @path
  @key("firmwareId")
  @segment("firmwares")
  name: string;
}

@armResourceOperations
@projectedName("client", "Firmware")
interface FirmwareOperationGroup {
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
  update is ArmCustomPatchSync<
    Firmware,
    FirmwareUpdateDefinition,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
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
    void,
    CryptoKeyList,
    {
      ...BaseParameters<Firmware>;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    }
  >;
}

@@projectedName(FirmwareOperationGroup.create::parameters.resource,
  "json",
  "firmware"
);
@@extension(FirmwareOperationGroup.create::parameters.resource,
  "x-ms-client-name",
  "firmware"
);
@@doc(FirmwareOperationGroup.create::parameters.resource,
  "Details of the firmware being created or updated."
);
@@projectedName(FirmwareOperationGroup.update::parameters.properties,
  "json",
  "firmware"
);
@@extension(FirmwareOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "firmware"
);
@@doc(FirmwareOperationGroup.update::parameters.properties,
  "Details of the firmware being created or updated."
);
