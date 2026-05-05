import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents FileWorkspaceDetails resource
 */
@subscriptionResource
model FileWorkspaceDetails
  is Azure.ResourceManager.ProxyResource<FileWorkspaceDetailsProperties> {
  ...ResourceNameParameter<
    Resource = FileWorkspaceDetails,
    KeyName = "fileWorkspaceName",
    SegmentName = "fileWorkspaces",
    NamePattern = "^[0-9a-zA-Z_\\-. ]+$"
  >;
}

@armResourceOperations
interface FileWorkspaceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = FileWorkspaceDetails,
        KeyName = "fileWorkspaceName",
        SegmentName = "fileWorkspaces",
        NamePattern = "^[0-9a-zA-Z_\\-. ]+$"
      >>
    > {}

@armResourceOperations
interface FileWorkspaces {
  /**
   * Gets details for a specific file workspace in an Azure subscription.
   */
  get is FileWorkspaceOps.Read<FileWorkspaceDetails>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates a new file workspace for the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is FileWorkspaceOps.CreateOrUpdateSync<
    FileWorkspaceDetails,
    Request = void,
    Response = ArmResourceCreatedSyncResponse<FileWorkspaceDetails>
  >;
}
@armResourceOperations
interface FileWorkspacesNoSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = FileWorkspaceDetails,
        KeyName = "fileWorkspaceName",
        SegmentName = "fileWorkspaces",
        NamePattern = "^[0-9a-zA-Z_\\-. ]+$"
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface FileWorkspacesNoSubscription {
  /**
   * Gets details for a specific file workspace.
   */
  get is FileWorkspacesNoSubscriptionOps.Read<FileWorkspaceDetails>;

  /**
   * Creates a new file workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is FileWorkspacesNoSubscriptionOps.CreateOrUpdateSync<
    FileWorkspaceDetails,
    Request = void,
    Response = ArmResourceCreatedSyncResponse<FileWorkspaceDetails>
  >;
}

@@doc(FileWorkspaceDetails.name, "File Workspace Name");
@@doc(FileWorkspaceDetails.properties, "Properties of the resource");
