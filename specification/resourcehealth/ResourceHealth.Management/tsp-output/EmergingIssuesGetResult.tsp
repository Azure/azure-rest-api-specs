import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
/**
 * The Get EmergingIssues operation response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EmergingIssue)
model EmergingIssuesGetResult extends ProxyResourceBase {
  /**
   * The name of the emerging issue.
   */
  @path
  @key("issueName")
  @segment("emergingIssues")
  @visibility("read")
  name: IssueNameParameter;

  /**
   * The emerging issue entity properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EmergingIssue;
}

@armResourceOperations
interface EmergingIssuesGetResults {
  /**
   * Gets Azure services' emerging issues.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmergingIssues_Get")
  get is ArmResourceRead<EmergingIssuesGetResult>;

  /**
   * Lists Azure services' emerging issues.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmergingIssues_List")
  list is ArmResourceListByParent<EmergingIssuesGetResult>;
}
