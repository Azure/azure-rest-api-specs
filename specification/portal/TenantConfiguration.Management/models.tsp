import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Portal;

@doc("The configuration name")
union ConfigurationName {
  string,

  @doc("The default configuration name")
  default: "default",
}

@doc("Tenant Configuration Properties with Provisioning state")
model ConfigurationProperties {
  /**
   * When flag is set to true Markdown tile will require external storage configuration (URI). The inline content configuration will be prohibited.
   */
  enforcePrivateMarkdownStorage?: boolean;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

/**
 * List of list of items that violate tenant's configuration.
 */
model ViolationsList is Azure.Core.Page<Violation>;

/**
 * Violation information.
 */
model Violation {
  /**
   * Id of the item that violates tenant configuration.
   */
  @visibility("read")
  id?: string;

  /**
   * Id of the user who owns violated item.
   */
  @visibility("read")
  userId?: string;

  /**
   * Error message.
   */
  @visibility("read")
  errorMessage?: string;
}
