import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureActiveDirectory;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning State
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,
  Provisioning: "Provisioning",
  Deleting: "Deleting",
  Deleted: "Deleted",
}

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}
