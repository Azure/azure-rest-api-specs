import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * user
   */
  user: "user",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * system
   */
  system: "system",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Internal
   */
  Internal: "Internal",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DefaultName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * The data boundary definition.
 */
union DataBoundary {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotDefined
   */
  NotDefined: "NotDefined",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Global
   */
  Global: "Global",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * EU
   */
  EU: "EU",
}

/**
 * Denotes the state of provisioning.
 */
union ProvisioningState {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Accepted
   */
  Accepted: "Accepted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Running
   */
  Running: "Running",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Creating
   */
  Creating: "Creating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Canceled
   */
  Canceled: "Canceled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application
   */
  Application: "Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Key
   */
  Key: "Key",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Data boundary properties
 */
model DataBoundaryProperties {
  /**
   * The data boundary definition.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataBoundary?: DataBoundary;

  /**
   * Denotes the state of provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
