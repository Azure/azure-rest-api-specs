import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database, Server or Elastic Pool Advisor.
 */
@parentResource(Database)
model Advisor is Azure.ResourceManager.ProxyResource<AdvisorProperties> {
  ...ResourceNameParameter<
    Resource = Advisor,
    KeyName = "advisorName",
    SegmentName = "advisors",
    NamePattern = ""
  >;

  /**
   * Resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias AdvisorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;
  },
  {
    /** The name of the Database Advisor. */
    @path
    @segment("advisors")
    @key
    advisorName: string;
  }
>;

@armResourceOperations
interface Advisors {
  /**
   * Gets a database advisor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvisors_Get")
  get is AdvisorOps.Read<Advisor>;

  /**
   * Updates a database advisor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvisors_Update")
  @patch(#{ implicitOptionality: false })
  update is AdvisorOps.CustomPatchSync<Advisor, PatchModel = Advisor>;

  /**
   * Gets a list of database advisors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvisors_ListByDatabase")
  listByDatabase is AdvisorOps.List<
    Advisor,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<Advisor[]>
  >;
}
alias ServerAdvisorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;
  },
  {
    /** The name of the Server Advisor. */
    @path
    @segment("advisors")
    @key
    advisorName: string;
  }
>;

@armResourceOperations
interface ServerAdvisors {
  /**
   * Gets a server advisor.
   */
  get is ServerAdvisorOps.Read<Advisor>;

  /**
   * Updates a server advisor.
   */
  @patch(#{ implicitOptionality: false })
  update is ServerAdvisorOps.CustomPatchSync<Advisor, PatchModel = Advisor>;

  /**
   * Gets a list of server advisors.
   */
  listByServer is ServerAdvisorOps.List<
    Advisor,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<Advisor[]>
  >;
}

@@doc(Advisor.name, "The name of the Database Advisor.");
@@doc(Advisor.properties, "Resource properties.");
@@doc(Advisors.update::parameters.properties,
  "The requested advisor resource state."
);
@@doc(ServerAdvisors.update::parameters.properties,
  "The requested advisor resource state."
);
