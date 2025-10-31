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
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FirmwareProperties)
model Firmware extends ProxyResourceBase {
  /**
   * The id of the firmware.
   */
  @path
  @key("firmwareId")
  @segment("firmwares")
  @visibility("read")
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_Get")
  get is ArmResourceRead<Firmware>;

  /**
   * The operation to create a firmware.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_Create")
  create is ArmResourceCreateOrReplaceSync<Firmware>;

  /**
   * The operation to update firmware.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Firmwares_Update")
  update is ArmCustomPatchSync<Firmware, FirmwareUpdateDefinition>;

  /**
   * The operation to delete a firmware.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_Delete")
  delete is ArmResourceDeleteSync<Firmware>;

  /**
   * Lists all of firmwares inside a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<Firmware>;

  /**
   * The operation to a url for file download.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_GenerateDownloadUrl")
  generateDownloadUrl is ArmResourceActionSync<Firmware, void, UrlToken>;

  /**
   * The operation to a url for tar file download.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firmwares_GenerateFilesystemDownloadUrl")
  generateFilesystemDownloadUrl is ArmResourceActionSync<
    Firmware,
    void,
    UrlToken
  >;

  /**
   * Lists binary hardening analysis results of a firmware.
   */
  // FIXME: BinaryHardening_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BinaryHardening_ListByFirmware")
  @segment("binaryHardeningResults")
  @get
  listBinaryHardeningResults (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<BinaryHardeningListResult> | ErrorResponse;

  /**
   * Lists cryptographic certificate analysis results found in a firmware.
   */
  // FIXME: CryptoCertificates_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CryptoCertificates_ListByFirmware")
  @segment("cryptoCertificates")
  @get
  listCryptoCertificates (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<CryptoCertificateListResult> | ErrorResponse;

  /**
   * Lists cryptographic key analysis results found in a firmware.
   */
  // FIXME: CryptoKeys_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CryptoKeys_ListByFirmware")
  @segment("cryptoKeys")
  @get
  listCryptoKeys (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<CryptoKeyListResult> | ErrorResponse;

  /**
   * Lists CVE analysis results of a firmware.
   */
  // FIXME: Cves_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Cves_ListByFirmware")
  @segment("cves")
  @get
  listCves (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<CveListResult> | ErrorResponse;

  /**
   * Lists password hash analysis results of a firmware.
   */
  // FIXME: PasswordHashes_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PasswordHashes_ListByFirmware")
  @segment("passwordHashes")
  @get
  listPasswordHashes (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<PasswordHashListResult> | ErrorResponse;

  /**
   * Lists SBOM analysis results of a firmware.
   */
  // FIXME: SbomComponents_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SbomComponents_ListByFirmware")
  @segment("sbomComponents")
  @get
  listSbomComponents (
    ...ResourceInstanceParameters<Firmware, BaseParameters<Firmware>>,

  ): ArmResponse<SbomComponentListResult> | ErrorResponse;
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
