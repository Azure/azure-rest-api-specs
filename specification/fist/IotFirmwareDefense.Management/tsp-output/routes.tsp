import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace fist;

interface FirmwareOperations {
  @doc("Lists all of firmwares inside a workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;
    },
    FirmwareList
  >;

  @doc("The operation to create a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;

      @doc("Details of the firmware being created or updated.")
      @body
      firmware: Firmware;
    },
    Firmware
  >;

  @doc("The operation to update firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;

      @doc("Details of the firmware being created or updated.")
      @body
      firmware: FirmwareUpdateDefinition;
    },
    Firmware
  >;

  @doc("The operation to delete a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    void
  >;

  @doc("Get firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    Firmware
  >;

  @doc("The operation to a url for file download.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateDownloadUrl")
  @post
  GenerateDownloadUrl is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    UrlToken
  >;

  @doc("The operation to a url for tar file download.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateFilesystemDownloadUrl")
  @post
  GenerateFilesystemDownloadUrl is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    UrlToken
  >;

  @doc("The operation to get a scan summary.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateSummary")
  @post
  GenerateSummary is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    FirmwareSummary
  >;

  @doc("The operation to list all components result for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateComponentList")
  @post
  ListGenerateComponentList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    ComponentList
  >;

  @doc("The operation to get component details for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateComponentDetails")
  @post
  GenerateComponentDetails is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    Component
  >;

  @doc("The operation to list all binary hardening result for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateBinaryHardeningList")
  @post
  ListGenerateBinaryHardeningList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    BinaryHardeningList
  >;

  @doc("The operation to list the binary hardening summary percentages for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateBinaryHardeningSummary")
  @post
  GenerateBinaryHardeningSummary is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    BinaryHardeningSummary
  >;

  @doc("The operation to get binary hardening details for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateBinaryHardeningDetails")
  @post
  GenerateBinaryHardeningDetails is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    BinaryHardening
  >;

  @doc("The operation to list all password hashes for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generatePasswordHashList")
  @post
  ListGeneratePasswordHashList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    PasswordHashList
  >;

  @doc("The operation to list all cve results for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCveList")
  @post
  ListGenerateCveList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CveList
  >;

  @doc("""
The operation to provide a high level summary of the CVEs reported for the
firmware image.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCveSummary")
  @post
  GenerateCveSummary is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CveSummary
  >;

  @doc("""
The operation to provide a high level summary of the discovered cryptographic
certificates reported for the firmware image.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCryptoCertificateSummary")
  @post
  GenerateCryptoCertificateSummary is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CryptoCertificateSummary
  >;

  @doc("""
The operation to provide a high level summary of the discovered cryptographic
keys reported for the firmware image.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCryptoKeySummary")
  @post
  GenerateCryptoKeySummary is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CryptoKeySummary
  >;

  @doc("The operation to list all crypto certificates for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCryptoCertificateList")
  @post
  ListGenerateCryptoCertificateList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CryptoCertificateList
  >;

  @doc("The operation to list all crypto keys for a firmware.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/firmwares/{firmwareId}/generateCryptoKeyList")
  @post
  ListGenerateCryptoKeyList is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("The id of the firmware.")
      @path
      firmwareId: string;
    },
    CryptoKeyList
  >;
}

interface WorkspacesOperations {
  @doc("Lists all of the firmware analysis workspaces in the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.IoTFirmwareDefense/workspaces")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    WorkspaceList
  >;

  @doc("Lists all of the firmware analysis workspaces in the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    WorkspaceList
  >;

  @doc("The operation to create or update a firmware analysis workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("Parameters when creating a firmware analysis workspace.")
      @body
      workspace: Workspace;
    },
    Workspace
  >;

  @doc("The operation to update a firmware analysis workspaces.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("Parameters when updating a firmware analysis workspace.")
      @body
      workspace: WorkspaceUpdateDefinition;
    },
    Workspace
  >;

  @doc("The operation to delete a firmware analysis workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;
    },
    void
  >;

  @doc("Get firmware analysis workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;
    },
    Workspace | void
  >;

  @doc("The operation to get a url for file upload.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTFirmwareDefense/workspaces/{workspaceName}/generateUploadUrl")
  @post
  GenerateUploadUrl is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the firmware analysis workspace.")
      @path
      workspaceName: string;

      @doc("Parameters when requesting a URL to upload firmware.")
      @body
      generateUploadUrl: GenerateUploadUrlRequest;
    },
    UrlToken
  >;
}

interface OperationsOperations {
  @doc("Lists the operations for this resource provider")
  @route("/providers/Microsoft.IoTFirmwareDefense/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
