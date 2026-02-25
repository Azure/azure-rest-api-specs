import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OracleInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The OracleDatabase resource definition.
 */
@parentResource(OracleSite)
model OracleDatabase
  is Azure.ResourceManager.ProxyResource<OracleDatabaseProperties, false> {
  ...ResourceNameParameter<
    Resource = OracleDatabase,
    KeyName = "databaseName",
    SegmentName = "oracleDatabases",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface OracleDatabases {
  /**
   * Gets the OracleDatabases resource.
   */
  get is ArmResourceRead<OracleDatabase>;
  /**
   * Puts the OracleDatabases resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<OracleDatabase>;

  /**
   * Patch the OracleDatabases resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    OracleDatabase,
    OracleDatabaseResourcePatchProperties
  >;

  /**
   * Deletes the OracleDatabases resource.
   */
  delete is ArmResourceDeleteSync<OracleDatabase>;

  /**
   * Lists the OracleDatabases resource in OracleSites.
   */
  listBySite is ArmResourceListByParent<
    OracleDatabase,
    Response = ArmResponse<OracleDatabaseList>
  >;
}

@@maxLength(OracleDatabase.name, 63);
@@minLength(OracleDatabase.name, 3);
@@doc(OracleDatabase.name, "The name of Database");
@@doc(OracleDatabase.properties, "Resource properties.");
@@doc(OracleDatabases.createOrUpdate::parameters.resource,
  "The request body for creating or updating a OracleDatabase resource."
);
@@doc(OracleDatabases.update::parameters.properties,
  "The request body for updating a OracleDatabase resource."
);
