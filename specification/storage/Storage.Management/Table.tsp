import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TableServiceProperties.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * Properties of the table, including Id, resource name, resource type.
 */
@parentResource(TableServiceProperties)
model Table is Azure.ResourceManager.ProxyResource<TableProperties> {
  ...ResourceNameParameter<
    Resource = Table,
    KeyName = "tableName",
    SegmentName = "tables",
    NamePattern = "^[A-Za-z][A-Za-z0-9]{2,62}$"
  >;
}

@armResourceOperations
interface TablesCreateOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        @path
        @segment("storageAccounts")
        @minLength(3)
        @maxLength(24)
        @pattern("^[a-z0-9]+$")
        @doc("The name of the storage account within the specified resource group. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.")
        accountName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("tableServices")
        default: "default",

        @path
        @segment("tables")
        @minLength(3)
        @maxLength(63)
        @pattern("^[A-Za-z][A-Za-z0-9]{2,62}$")
        @doc("A table name must be unique within a storage account and must be between 3 and 63 characters.The name must comprise of only alphanumeric characters and it cannot begin with a numeric character.")
        tableName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Table,
        KeyName = "tableName",
        SegmentName = "tables",
        NamePattern = "^[A-Za-z][A-Za-z0-9]{2,62}$"
      >>
    > {}

@armResourceOperations
interface Tables {
  /**
   * Gets the table with the specified table name, under the specified account if it exists.
   */
  get is ArmResourceRead<Table, Error = CloudError>;

  /**
   * Creates a new table with the specified table name, under the specified account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is TablesCreateOps.CreateOrUpdateSync<
    Table,
    Response = ArmResourceUpdatedResponse<Table>,
    OverrideErrorType = CloudError,
    OptionalRequestBody = true
  >;
  /**
   * Creates a new table with the specified table name, under the specified account.
   */
  @patch(#{ implicitOptionality: false })
  update is TablesCreateOps.CustomPatchSync<
    Table,
    PatchModel = Table,
    Response = ArmResourceUpdatedResponse<Table>,
    OverrideErrorType = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * Deletes the table with the specified table name, under the specified account if it exists.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    Table,
    Response = ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets a list of all the tables under the specified storage account
   */
  list is ArmResourceListByParent<
    Table,
    Response = ArmResponse<ListTableResource>,
    Error = CloudError
  >;
}

@@maxLength(Table.name, 63);
@@minLength(Table.name, 3);
@@doc(Table.name,
  "A table name must be unique within a storage account and must be between 3 and 63 characters.The name must comprise of only alphanumeric characters and it cannot begin with a numeric character."
);
@@doc(Table.properties, "Table resource properties.");
@@doc(Tables.create::parameters.resource,
  "The parameters to provide to create a table."
);
@@doc(Tables.update::parameters.properties,
  "The parameters to provide to create a table."
);
