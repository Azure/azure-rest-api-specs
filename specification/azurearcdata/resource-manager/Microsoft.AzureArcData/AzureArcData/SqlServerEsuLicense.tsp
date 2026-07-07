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
 * Describe SQL Server ESU license resource.
 */
model SqlServerEsuLicense
  is Azure.ResourceManager.TrackedResource<
    SqlServerEsuLicenseProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SqlServerEsuLicense,
    KeyName = "sqlServerEsuLicenseName",
    SegmentName = "sqlServerEsuLicenses",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface SqlServerEsuLicenses {
  /**
   * Retrieves a SQL Server ESU license resource
   */
  get is ArmResourceRead<SqlServerEsuLicense>;

  /**
   * Creates or replaces a SQL Server ESU license resource
   */
  create is ArmResourceCreateOrReplaceSync<SqlServerEsuLicense>;

  /**
   * Updates a SQL Server ESU license resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SqlServerEsuLicense,
    PatchModel = SqlServerEsuLicenseUpdate
  >;

  /**
   * Deletes a SQL Server ESU license resource
   */
  delete is ArmResourceDeleteSync<SqlServerEsuLicense>;

  /**
   * Gets all sqlServerEsuLicenses in a resource group.
   */
  @summary("List sqlServerEsuLicense resources in the resource group")
  listByResourceGroup is ArmResourceListByParent<
    SqlServerEsuLicense,
    Response = ArmResponse<SqlServerEsuLicenseListResult>
  >;

  /**
   * List sqlServerEsuLicense resources in the subscription
   */
  @summary("List sqlServerEsuLicense resources in the subscription")
  list is ArmListBySubscription<
    SqlServerEsuLicense,
    Response = ArmResponse<SqlServerEsuLicenseListResult>
  >;
}

@@doc(SqlServerEsuLicense.name, "Name of SQL Server ESU License");
@@doc(SqlServerEsuLicense.properties, "SQL Server ESU license properties");
@@doc(
  SqlServerEsuLicenses.create::parameters.resource,
  "The SQL Server ESU license to be created or updated."
);
@@doc(
  SqlServerEsuLicenses.update::parameters.properties,
  "The SQL Server ESU license."
);
