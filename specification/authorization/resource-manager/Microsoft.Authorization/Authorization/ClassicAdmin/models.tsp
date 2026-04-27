import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ClassicAdmin;

/**
 * Classic Administrators
 */
model ClassicAdministrator {
  /**
   * The ID of the administrator.
   */
  id?: string;

  /**
   * The name of the administrator.
   */
  name?: string;

  /**
   * The type of the administrator.
   */
  type?: string;

  /**
   * Properties for the classic administrator.
   */
  properties?: ClassicAdministratorProperties;
}

/**
 * Classic Administrator properties.
 */
model ClassicAdministratorProperties {
  /**
   * The email address of the administrator.
   */
  emailAddress?: string;

  /**
   * The role of the administrator.
   */
  role?: string;
}
