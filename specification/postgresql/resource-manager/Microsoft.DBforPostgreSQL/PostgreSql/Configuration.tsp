import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

using TypeSpec.Versioning;

namespace Microsoft.DBforPostgreSQL;

/**
 * Data type of the configuration (also known as server parameter).
 */
union ConfigurationDataType {
  string,

  /** A boolean value. */
  Boolean: "Boolean",

  /** A numeric value. */
  Numeric: "Numeric",

  /** An integer value. */
  Integer: "Integer",

  /** An enumeration value. */
  Enumeration: "Enumeration",

  /** A string value. */
  String: "String",

  /** A set of values. */
  Set: "Set",
}

/**
 * List of configurations (also known as server parameters).
 */
model ConfigurationList is Azure.Core.Page<Configuration>;

/**
 * Properties of a configuration (also known as server parameter).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProperties {
  /**
   * Value of the configuration (also known as server parameter). Required to update the value assigned to a specific modifiable configuration.
   */
  value?: string;

  /**
   * Description of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Value assigned by default to the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  defaultValue?: string;

  /**
   * Data type of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  dataType?: ConfigurationDataType;

  /**
   * Allowed values of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  allowedValues?: string;

  /**
   * Source of the value assigned to the configuration (also known as server parameter). Required to update the value assigned to a specific modifiable configuration.
   */
  source?: string;

  /**
   * Indicates if it's a dynamic (true) or static (false) configuration (also known as server parameter). Static server parameters require a server restart after changing the value assigned to them, for the change to take effect. Dynamic server parameters do not require a server restart after changing the value assigned to them, for the change to take effect.
   */
  @visibility(Lifecycle.Read)
  isDynamicConfig?: boolean;

  /**
   * Indicates if it's a read-only (true) or modifiable (false) configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  isReadOnly?: boolean;

  /**
   * Indicates if the value assigned to the configuration (also known as server parameter) is pending a server restart for it to take effect.
   */
  @visibility(Lifecycle.Read)
  isConfigPendingRestart?: boolean;

  /**
   * Units in which the configuration (also known as server parameter) value is expressed.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Link pointing to the documentation of the configuration (also known as server parameter).
   */
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

/**
 * Configuration (also known as server parameter).
 */
model ConfigurationForUpdate {
  /**
   * Properties of a configuration (also known as server parameter).
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConfigurationProperties;
}

/**
 * Configuration (also known as server parameter).
 */
@parentResource(Server)
model Configuration
  is Azure.ResourceManager.ProxyResource<ConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = Configuration,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Configurations {
  /**
   * Gets information about a specific configuration (also known as server parameter) of a server.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Updates, using Put verb, the value assigned to a specific modifiable configuration (also known as server parameter) of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @useFinalStateVia("azure-async-operation")
  @put
  put is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Configuration,
    ConfigurationForUpdate,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Configuration> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates the value assigned to a specific modifiable configuration (also known as server parameter) of a server.
   */
  @patch(#{ implicitOptionality: false })
  @useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    Configuration,
    PatchModel = ConfigurationForUpdate,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Configuration> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists all configurations (also known as server parameters) of a server.
   */
  listByServer is ArmResourceListByParent<
    Configuration,
    Response = ArmResponse<ConfigurationList>
  >;
}

@@maxLength(Configuration.name, 256);
@@minLength(Configuration.name, 1);
@@doc(
  Configuration.name,
  "Name of the configuration (also known as server parameter)."
);
@@doc(
  Configuration.properties,
  "Properties of a configuration (also known as server parameter)."
);
@@doc(
  Configurations.put::parameters.resource,
  "Parameters required to update the value of a specific modifiable configuration (also known as server parameter)."
);
@@doc(
  Configurations.update::parameters.properties,
  "Parameters required to update the value of a specific modifiable configuration (also known as server parameter)."
);
