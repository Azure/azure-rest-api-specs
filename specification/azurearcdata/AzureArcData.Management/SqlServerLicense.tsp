import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * Describe SQL Server license resource.
 */
model SqlServerLicense is Azure.ResourceManager.TrackedResource<
  SqlServerLicenseProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = SqlServerLicense,
    KeyName = "sqlServerLicenseName",
    SegmentName = "sqlServerLicenses",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface SqlServerLicenses {
  /**
   * Retrieves a SQL Server license resource
   */
  get is ArmResourceRead<SqlServerLicense>;

  /**
   * Creates or replaces a SQL Server license resource
   */
  create is ArmResourceCreateOrReplaceSync<SqlServerLicense>;

  /**
   * Updates a SQL Server license resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SqlServerLicense,
    PatchModel = SqlServerLicenseUpdate
  >;

  /**
   * Deletes a SQL Server license resource
   */
  delete is ArmResourceDeleteSync<SqlServerLicense>;

  /**
   * Gets all sqlServerLicenses in a resource group.
   */
  @summary("List sqlServerLicense resources in the resource group")
  listByResourceGroup is ArmResourceListByParent<
    SqlServerLicense,
    Response = ArmResponse<SqlServerLicenseListResult>
  >;

  /**
   * List sqlServerLicense resources in the subscription
   */
  @summary("List sqlServerLicense resources in the subscription")
  list is ArmListBySubscription<
    SqlServerLicense,
    Response = ArmResponse<SqlServerLicenseListResult>
  >;
}

@@doc(SqlServerLicense.name, "Name of SQL Server License");
@@doc(SqlServerLicense.properties, "SQL Server license properties");
@@doc(
  SqlServerLicenses.create::parameters.resource,
  "The SQL Server license to be created or updated."
);
@@doc(
  SqlServerLicenses.update::parameters.properties,
  "The SQL Server license."
);
