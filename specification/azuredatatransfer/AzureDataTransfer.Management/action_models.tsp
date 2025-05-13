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

/**
 * The schema object.
 */
model Schema {
  /**
   * ID associated with this schema
   */
  id?: string;

  /**
   * Connection ID associated with this schema
   */
  connectionId?: string;

  /**
   * Status of the schema
   */
  status?: SchemaStatus;

  /**
   * Name of the schema
   */
  name?: string;

  /**
   * Content of the schema
   */
  content?: string;

  /**
   * The direction of the schema.
   */
  direction?: SchemaDirection;

  /**
   * Uri containing SAS token for the zipped schema
   */
  schemaUri?: url;

  /**
   * The Schema Type
   */
  schemaType?: SchemaType;
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
