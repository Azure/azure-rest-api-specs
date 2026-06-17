import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database, Server or Elastic Pool Advisor.
 */
@parentResource(Database)
model Advisor is ProxyResource<AdvisorProperties> {
  /**
   * The name of the Database Advisor.
   */
  @path
  @key("advisorName")
  @segment("advisors")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Advisors {
  /**
   * Gets a database advisor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAdvisors_Get")
  get is ArmResourceRead<Advisor>;

  /**
   * Updates a database advisor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DatabaseAdvisors_Update")
  update is ArmCustomPatchSync<Advisor, Advisor>;

  /**
   * Gets a list of database advisors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAdvisors_ListByDatabase")
  listByDatabase is ArmResourceListByParent<
    Advisor,
    {
      ...BaseParameters<Advisor>;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(Advisors.update::parameters.properties, "json", "parameters");
@@extension(Advisors.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Advisors.update::parameters.properties,
  "The requested advisor resource state."
);
