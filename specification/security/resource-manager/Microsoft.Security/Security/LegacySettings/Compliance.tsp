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

namespace Microsoft.Security;
/**
 * Compliance of a scope
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model Compliance
  is Azure.ResourceManager.ExtensionResource<ComplianceProperties> {
  ...ResourceNameParameter<
    Resource = Compliance,
    KeyName = "complianceName",
    SegmentName = "compliances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Compliances {
  /**
   * Details of a specific Compliance.
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    Compliance,
    Error = CloudError
  >;

  /**
   * The Compliance scores of the specific management group.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    Compliance,
    Response = ArmResponse<ComplianceList>,
    Error = CloudError
  >;
}

@@doc(Compliance.name, "name of the Compliance");
@@doc(Compliance.properties, "Compliance data");


