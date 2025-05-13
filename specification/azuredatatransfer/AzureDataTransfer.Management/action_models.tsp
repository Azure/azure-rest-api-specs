import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

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

/**
 * The request used to list approved schemas within the resource provider.
 */
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
 * Status of the schema.
 */
union SchemaStatus {
  string,

  /**
   * A schema that has not been approved and is awaiting review.
   */
  New: "New",

  /**
   * A schema that has been approved and is ready for use.
   */
  Approved: "Approved",
}

/**
 * The direction of the schema.
 */
union SchemaDirection {
  Direction,
}

/**
 * The Schema Type.
 */
union SchemaType {
  string,

  /**
   * The schema represents a single XML schema definition file.
   */
  Xsd: "Xsd",

  /**
   * The schema represents a ZIP file with multiple XML schema definition files within it.
   */
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

  /**
   * Validation of the schema was successful.
   */
  Succeeded: "Succeeded",

  /**
   * The schema failed validation, whether due to error or an invalid schema.
   */
  Failed: "Failed",
}
