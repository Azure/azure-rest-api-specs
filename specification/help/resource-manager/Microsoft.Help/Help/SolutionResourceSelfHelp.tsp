import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Self Help Solution response.
 */
@tenantResource
model SolutionResourceSelfHelp
  is Azure.ResourceManager.ProxyResource<SolutionsResourcePropertiesSelfHelp> {
  ...ResourceNameParameter<
    Resource = SolutionResourceSelfHelp,
    KeyName = "solutionId",
    SegmentName = "selfHelp",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SolutionResourceSelfHelps {
  /**
   * Gets Self Help Solutions for a given solutionId. Self Help Solutions consist of rich instructional video tutorials, links and guides to public documentation related to a specific problem that enables users to troubleshoot Azure issues.
   */
  get is Extension.Read<Extension.Tenant, SolutionResourceSelfHelp>;
}

@@maxLength(SolutionResourceSelfHelp.name, 100);
@@minLength(SolutionResourceSelfHelp.name, 1);
@@doc(SolutionResourceSelfHelp.name,
  "SolutionId is a unique id to identify a solution. You can retrieve the solution id using the Discovery api - https://learn.microsoft.com/en-us/rest/api/help/discovery-solution/list?view=rest-help-2023-09-01-preview&tabs=HTTP"
);
@@doc(SolutionResourceSelfHelp.properties, "Solution result");
