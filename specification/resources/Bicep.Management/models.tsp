import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace BicepClient;

/**
 * The body of the request for the decompileBicep operation
 */
model DecompileOperationRequest {
  /**
   * The ARM json template to be decompiled into a Bicep file
   */
  template: string;
}

/**
 * The response of the decompileBicep operation
 */
model DecompileOperationSuccessResponse {
  /**
   * An array of key-value pairs containing the entryPoint string as the key for the Bicep file decompiled from the ARM json template
   */
  @OpenAPI.extension("x-ms-identifiers", #["path"])
  files: FileDefinition[];

  /**
   * The file path to the main Bicep file generated from the decompiled ARM json template.
   */
  entryPoint: string;
}

/**
 * The definition of a file along with its contents
 */
model FileDefinition {
  /**
   * The file path of the Bicep file.
   */
  path?: string;

  /**
   * The contents of the Bicep file.
   */
  contents?: string;
}
