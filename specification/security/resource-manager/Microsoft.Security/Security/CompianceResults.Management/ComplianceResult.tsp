import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * a compliance result
 */
@extensionResource
model ComplianceResult
  is Azure.ResourceManager.ExtensionResource<ComplianceResultProperties> {
  ...ResourceNameParameter<
    Resource = ComplianceResult,
    KeyName = "complianceResultName",
    SegmentName = "complianceResults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComplianceResults {
  /**
   * Security Compliance Result
   */
  get is Extension.Read<Extension.ScopeParameter, ComplianceResult>;

  /**
   * Security compliance results in the subscription
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    ComplianceResult,
    Parameters = {
      /**
       * Scope of the query, can be subscription (/subscriptions/0b06d9ea-afe6-4779-bd59-30e5c2d9d13f) or management group (/providers/Microsoft.Management/managementGroups/mgName).
       */
      @path
      scope: string;
    },
    Response = ArmResponse<ComplianceResultList>
  >;
}

@@doc(ComplianceResult.name,
  "name of the desired assessment compliance result"
);
@@doc(ComplianceResult.properties, "Compliance result data");
