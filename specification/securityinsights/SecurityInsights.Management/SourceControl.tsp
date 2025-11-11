import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a SourceControl in Azure Security Insights.
 */
model SourceControl
  is Azure.ResourceManager.ProxyResource<SourceControlProperties, false> {
  ...ResourceNameParameter<
    Resource = SourceControl,
    KeyName = "sourceControlId",
    SegmentName = "sourcecontrols",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias SourceControlWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface SourceControls {
  /**
   * Gets a source control byt its identifier.
   */
  get is ArmResourceRead<SourceControl>;

  /**
   * Creates a source control.
   */
  create is ArmResourceCreateOrReplaceSync<SourceControl>;

  /**
   * Gets all source controls, without source control items.
   */
  list is ArmResourceListByParent<
    SourceControl,
    Response = ArmResponse<SourceControlList>
  >;

  /**
   * Delete a source control.
   */
  delete is ArmResourceActionSync<
    SourceControl,
    RepositoryAccessProperties,
    ArmResponse<Warning>
  >;
}

@@doc(SourceControl.name, "Source control Id");
@@doc(SourceControl.properties, "source control properties");
@@doc(SourceControls.create::parameters.resource, "The SourceControl");
@@doc(SourceControls.delete::parameters.body,
  "The repository access credentials."
);
