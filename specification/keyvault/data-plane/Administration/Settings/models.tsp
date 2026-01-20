import "@typespec/http";
import "../common/common.tsp";

using TypeSpec.Http;

namespace KeyVault;

/**
 * Setting name parameter.
 */
model SettingNameParameter {
  /**
   * The name of the account setting. Must be a valid settings option.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
  @OpenAPI.extension("x-ms-parameter-location", "method")
  @path
  `setting-name`: string;
}

/**
 * The type specifier of the value.
 */
union SettingTypeEnum {
  string,

  /**
   * A boolean setting value.
   */
  boolean: "boolean",
}

/**
 * The update settings request object.
 */
model UpdateSettingRequest {
  /**
   * The value of the pool setting.
   */
  value: string;
}

/**
 * A Key Vault account setting.
 */
model Setting {
  /**
   * The account setting to be updated
   */
  name: string;

  /**
   * The value of the pool setting.
   */
  value: string;

  /**
   * The type specifier of the value.
   */
  type?: SettingTypeEnum;
}

/**
 * The settings list result.
 */
model SettingsListResult {
  /**
   * A response message containing a list of account settings with their associated value.
   */
  @visibility(Lifecycle.Read)
  settings?: Setting[];
}
