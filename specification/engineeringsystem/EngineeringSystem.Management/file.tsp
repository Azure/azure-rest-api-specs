import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EngineeringSystem;

@parentResource(Product)
model File is ProxyResource<FileProperties> {
  ...ResourceNameParameter<File>;
}

/** The properties of file resource. */
model FileProperties {
  /** The file name. */
  fileName: string;

  /** The path for the file. */
  filePath?: string;

  /** The file SPDX ID. */
  spdxId?: string;

  /** The SHA-256 digest of the file. */
  sha256: string;

  /** The file license. */
  license?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Files {
  get is ArmResourceRead<File>;
  listByParent is ArmResourceListByParent<File>;
}
