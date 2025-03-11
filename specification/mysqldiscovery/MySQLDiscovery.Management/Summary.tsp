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

namespace Microsoft.MySQLDiscovery;
/**
 * The Summary resource definition.
 */
@parentResource(MySQLSite)
model Summary
  is Azure.ResourceManager.ProxyResource<SummariesProperties, false> {
  ...ResourceNameParameter<
    Resource = Summary,
    KeyName = "summaryName",
    SegmentName = "summaries",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For Backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface Summaries {
  /**
   * Gets the Summaries resource.
   */
  get is ArmResourceRead<Summary>;

  /**
   * Lists the Summaries resource in MySQLSites.
   */
  listBySite is ArmResourceListByParent<
    Summary,
    Response = ArmResponse<SummaryList>
  >;
}

@@maxLength(Summary.name, 63);
@@minLength(Summary.name, 3);
@@doc(Summary.name, "The name of summary");
@@doc(Summary.properties, "Resource properties.");
