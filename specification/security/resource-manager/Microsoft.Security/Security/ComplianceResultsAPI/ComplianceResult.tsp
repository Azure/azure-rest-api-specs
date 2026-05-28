import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace ComplianceResultsAPI;
/**
 * a compliance result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

alias ComplianceResultOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The compliance result key. */
    @path
    @segment("complianceResults")
    @key
    complianceResultName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ComplianceResults {
  /**
   * Security Compliance Result
   */
  @tag("Compliance Results")
  get is ComplianceResultOps.Read<ComplianceResult, ErrorType = CloudError>;

  /**
   * Security compliance results in the subscription
   */
  @tag("Compliance Results")
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    ComplianceResult,
    Response = ArmResponse<ComplianceResultList>,
    Error = CloudError
  >;
}

@@doc(ComplianceResult.name,
  "name of the desired assessment compliance result"
);
@@doc(ComplianceResult.properties, "Compliance result data");
