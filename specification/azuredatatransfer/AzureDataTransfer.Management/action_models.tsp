import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AzureDataTransfer;

/**
 * The schemas list result.
 */
model SchemasListResult {
  /**
   * Schemas array.
   */
  value?: Schema[];
}

model ListApprovedSchemasRequest {
  /**
   * The name of the pipeline to filter approved schemas.
   */
  pipeline?: string;

  /**
   * The direction pipeline to filter approved schemas.
   */
  direction?: ListApprovedSchemasDirection;
}

/**
 * The direction pipeline to filter approved schemas.
 */
union ListApprovedSchemasDirection {
  Direction,
}

/**
 * Status of the schema
 */
union SchemaStatus {
  string,
  New: "New",
  Approved: "Approved",
}

/**
 * The direction of the schema.
 */
union SchemaDirection {
  Direction,
}

/**
 * The Schema Type
 */
union SchemaType {
  string,
  Xsd: "Xsd",
  Zip: "Zip",
}

/**
 * Result of the schema validation.
 */
model ValidateSchemaResult {
  /**
   * Validation status of the schema
   */
  status?: ValidateSchemaStatus;

  /**
   * Message describing the schema validation
   */
  message?: string;
}

/**
 * Validation status of the schema
 */
union ValidateSchemaStatus {
  string,
  Succeeded: "Succeeded",
  Failed: "Failed",
}
