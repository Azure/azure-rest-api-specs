import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Role based access control provides you a way to apply granular level policy administration down to individual resources or resource groups. These operations enable you to manage role assignments. A role assignment grants access to Azure Active Directory users.
 */
namespace Microsoft.Common;

/**
 * The name of the entity last modified it
 */
model Principal {
  /**
   * The id of the principal made changes
   */
  id?: string;

  /**
   * The name of the principal made changes
   */
  displayName?: string;

  /**
   * Type of principal such as user , group etc
   */
  type?: string;

  /**
   * Email of principal
   */
  email?: string;
}

/**
 * The principal type of the assigned principal ID.
 */
union PrincipalType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Group
   */
  Group: "Group",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * ForeignGroup
   */
  ForeignGroup: "ForeignGroup",

  /**
   * Device
   */
  Device: "Device",
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;
}
