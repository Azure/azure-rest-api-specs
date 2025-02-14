import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MySQLSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySqlDiscovery;
/**
 * The ErrorSummary resource definition.
 */
@parentResource(MySQLSite)
model ErrorSummary
  is Azure.ResourceManager.ProxyResource<ErrorSummariesProperties, false> {
  ...ResourceNameParameter<
    Resource = ErrorSummary,
    KeyName = "errorSummaryName",
    SegmentName = "errorSummaries",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

@armResourceOperations
interface ErrorSummaries {
  /**
   * Gets the ErrorSummaries resource.
   */
  get is ArmResourceRead<ErrorSummary>;

  /**
   * Lists the ErrorSummaries resource in MySQLSites.
   */
  listBySite is ArmResourceListByParent<
    ErrorSummary,
    Response = ArmResponse<ErrorSummaryList>
  >;
}

@@maxLength(ErrorSummary.name, 63);
@@minLength(ErrorSummary.name, 3);
@@doc(ErrorSummary.name, "The name of Database");
@@doc(ErrorSummary.properties, "Resource properties.");
