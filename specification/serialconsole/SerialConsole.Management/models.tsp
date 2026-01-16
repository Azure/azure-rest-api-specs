import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SerialConsole;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Specifies whether the port is enabled for a serial console connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SerialPortState {
  /**
   * enabled
   */
  enabled,

  /**
   * disabled
   */
  disabled,
}

/**
 * Specifies whether the port is currently active.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SerialPortConnectionState {
  /**
   * active
   */
  active,

  /**
   * inactive
   */
  inactive,
}

/**
 * Serial Console operations
 */
@summary("Serial Console operations")
model SerialConsoleOperations {
  /**
   * A list of Serial Console operations
   */
  @identifiers(#["name"])
  @pageItems
  value?: SerialConsoleOperationsValueItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SerialConsoleOperationsValueItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  isDataAction?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  display?: SerialConsoleOperationsValueItemDisplay;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SerialConsoleOperationsValueItemDisplay {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  provider?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resource?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operation?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  description?: string;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Cloud error body.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Batch service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME"
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

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#["code"])
  details?: CloudErrorBody[];
}

/**
 * Returns whether or not Serial Console is disabled.
 */
@summary("Serial Console GET Result")
model SerialConsoleStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: SerialConsoleStatusProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SerialConsoleStatusProperties {
  /**
   * Whether or not Serial Console is disabled.
   */
  disabled?: boolean;
}

/**
 * Subscription not found - returns a JSON object with error details
 */
@error
model GetSerialConsoleSubscriptionNotFoundError {
  ...NotFoundResponse;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME"
  @bodyRoot body: GetSerialConsoleSubscriptionNotFound;
}

/**
 * Error saying that the provided subscription could not be found
 */
@error
@summary("Serial Console subscription not found")
model GetSerialConsoleSubscriptionNotFound {
  /**
   * Error code
   */
  code?: string;

  /**
   * Subscription not found message
   */
  message?: string;
}

/**
 * Returns whether or not Serial Console is disabled.
 */
@summary("Serial Console Disable Result")
model DisableSerialConsoleResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: DisableSerialConsoleResultProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DisableSerialConsoleResultProperties {
  /**
   * Whether or not Serial Console is disabled.
   */
  disabled?: boolean;
}

/**
 * Returns whether or not Serial Console is disabled (enabled).
 */
model EnableSerialConsoleResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: EnableSerialConsoleResultProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EnableSerialConsoleResultProperties {
  /**
   * Whether or not Serial Console is disabled.
   */
  disabled?: boolean;
}

/**
 * The list serial ports operation response.
 */
@summary("Serial port list result")
model SerialPortListResult {
  /**
   * The list of serial ports.
   */
  @pageItems
  value?: SerialPort[];
}

/**
 * The properties of the serial port.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SerialPortProperties {
  /**
   * Specifies whether the port is enabled for a serial console connection.
   */
  state?: SerialPortState;

  /**
   * Specifies whether the port is currently active.
   */
  connectionState?: SerialPortConnectionState;
}

/**
 * Returns a connection string to the serial port of the resource.
 */
@summary("Serial port connect result")
model SerialPortConnectResult {
  /**
   * Connection string to the serial port of the resource.
   */
  connectionString?: string;
}
