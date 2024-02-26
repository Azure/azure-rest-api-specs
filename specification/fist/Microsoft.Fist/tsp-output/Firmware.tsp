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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/binaryHardeningResults")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    BinaryHardeningListResult
  >;

  /**
   * Lists cryptographic certificate analysis results found in a firmware.
   */
  // FIXME: CryptoCertificates_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CryptoCertificates_ListByFirmware")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/cryptoCertificates")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    CryptoCertificateListResult
  >;

  /**
   * Lists cryptographic key analysis results found in a firmware.
   */
  // FIXME: CryptoKeys_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CryptoKeys_ListByFirmware")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/cryptoKeys")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    CryptoKeyListResult
  >;

  /**
   * Lists CVE analysis results of a firmware.
   */
  // FIXME: Cves_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Cves_ListByFirmware")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/cves")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    CveListResult
  >;

  /**
   * Lists password hash analysis results of a firmware.
   */
  // FIXME: PasswordHashes_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PasswordHashes_ListByFirmware")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/passwordHashes")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    PasswordHashListResult
  >;

  /**
   * Lists SBOM analysis results of a firmware.
   */
  // FIXME: SbomComponents_ListByFirmware could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SbomComponents_ListByFirmware")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/sbomComponents")
  @get
  listByFirmware is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the firmware analysis workspace.
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      workspaceName: string;

      /**
       * The id of the firmware.
       */
      @path
      firmwareId: string;
    },
    SbomComponentListResult
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
