import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface SourceControls {
  /**
   * Gets a source control byt its identifier.
   */
  get is Extension.Read<OperationalInsights, SourceControl, Error = CloudError>;

  /**
   * Creates a source control.
   */
  create is Extension.CreateOrReplaceSync<
    OperationalInsights,
    SourceControl,
    Error = CloudError
  >;

  /**
   * Gets all source controls, without source control items.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    SourceControl,
    Response = ArmResponse<SourceControlList>,
    Error = CloudError
  >;

  /**
   * Delete a source control.
   */
  delete is Extension.ActionSync<
    OperationalInsights,
    SourceControl,
    RepositoryAccessProperties,
    ArmResponse<Warning>,
    Error = CloudError
  >;
}

@@doc(SourceControl.name, "Source control Id");
@@doc(SourceControl.properties, "source control properties");
@@doc(SourceControls.create::parameters.resource, "The SourceControl");
@@doc(SourceControls.delete::parameters.body,
  "The repository access credentials."
);
