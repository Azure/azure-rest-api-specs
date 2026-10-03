import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../service.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * Properties of a trace association.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The existing synchronous trace association service contract does not expose provisioningState."
  @added(Versions.v2026_09_03_preview)
  model TraceAssociation {
    /**
     * The resource ID of the Azure Monitor Workspace that receives traces from the target scope.
     */
    azureMonitorWorkspaceResourceId: armResourceIdentifier;
  }

  /**
   * An association between an Azure resource scope and an Azure Monitor Workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The extension resource has a singleton resource name in addition to the target scope parameters."
  @added(Versions.v2026_09_03_preview)
  @singleton("default")
  @extensionResource
  model TraceAssociationResource
    is Azure.ResourceManager.ExtensionResource<TraceAssociation> {
    ...ResourceNameParameter<
      Resource = TraceAssociationResource,
      KeyName = "traceAssociationName",
      SegmentName = "traceAssociations",
      /**
       * The name of the trace association. Always 'default'.
       */
      NamePattern = "^default$"
    >;
  }
}
