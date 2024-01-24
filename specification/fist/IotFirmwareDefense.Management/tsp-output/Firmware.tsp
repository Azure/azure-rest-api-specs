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
/**
 * Firmware definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@Azure.ResourceManager.Private.armResourceInternal(FirmwareProperties)
@includeInapplicableMetadataInPayload(false)
model Firmware extends ProxyResourceBase {
  /**
   * The id of the firmware.
   */
  @path
  @key("firmwareId")
  @segment("firmwares")
  name: string;

  /**
   * The properties of a firmware
   */
  @extension("x-ms-client-flatten", true)
  properties?: FirmwareProperties;
}

@armResourceOperations
@projectedName("client", "Firmware")
interface FirmwareOperationGroup {
  /**
   * Get firmware.
   */
  get is ArmResourceRead<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to create a firmware.
   */
  create is ArmResourceCreateOrReplaceSync<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to update firmware.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    Firmware,
    FirmwareUpdateDefinition,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to delete a firmware.
   */
  delete is ArmResourceDeleteSync<
    Firmware,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * Lists all of firmwares inside a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmware_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<Firmware>;

  /**
   * The operation to a url for file download.
   */
  generateDownloadUrl is ArmResourceActionSync<
    Firmware,
    void,
    UrlToken,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to a url for tar file download.
   */
  generateFilesystemDownloadUrl is ArmResourceActionSync<
    Firmware,
    void,
    UrlToken,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to get a scan summary.
   */
  generateSummary is ArmResourceActionSync<
    Firmware,
    void,
    FirmwareSummary,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all components result for a firmware.
   */
  listGenerateComponentList is ArmResourceActionSync<
    Firmware,
    void,
    ComponentList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to get component details for a firmware.
   */
  generateComponentDetails is ArmResourceActionSync<
    Firmware,
    void,
    Component,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all binary hardening result for a firmware.
   */
  listGenerateBinaryHardeningList is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardeningList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list the binary hardening summary percentages for a firmware.
   */
  generateBinaryHardeningSummary is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardeningSummary,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to get binary hardening details for a firmware.
   */
  generateBinaryHardeningDetails is ArmResourceActionSync<
    Firmware,
    void,
    BinaryHardening,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all password hashes for a firmware.
   */
  listGeneratePasswordHashList is ArmResourceActionSync<
    Firmware,
    void,
    PasswordHashList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all cve results for a firmware.
   */
  listGenerateCveList is ArmResourceActionSync<
    Firmware,
    void,
    CveList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to provide a high level summary of the CVEs reported for the firmware image.
   */
  generateCveSummary is ArmResourceActionSync<
    Firmware,
    void,
    CveSummary,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to provide a high level summary of the discovered cryptographic certificates reported for the firmware image.
   */
  generateCryptoCertificateSummary is ArmResourceActionSync<
    Firmware,
    void,
    CryptoCertificateSummary,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to provide a high level summary of the discovered cryptographic keys reported for the firmware image.
   */
  generateCryptoKeySummary is ArmResourceActionSync<
    Firmware,
    void,
    CryptoKeySummary,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all crypto certificates for a firmware.
   */
  listGenerateCryptoCertificateList is ArmResourceActionSync<
    Firmware,
    void,
    CryptoCertificateList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    }
  >;

  /**
   * The operation to list all crypto keys for a firmware.
   */
  listGenerateCryptoKeyList is ArmResourceActionSync<
    Firmware,
    void,
    CryptoKeyList,
    {
      ...BaseParameters<Firmware>;

      /**
       * The id of the firmware.
       */
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
