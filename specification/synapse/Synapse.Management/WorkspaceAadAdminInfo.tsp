import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Workspace active directory administrator
 */
@singleton("activeDirectory")
@parentResource(Workspace)
model WorkspaceAadAdminInfo
  is Azure.ResourceManager.ProxyResource<AadAdminProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceAadAdminInfo,
    KeyName = "administrator",
    SegmentName = "administrators",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkspaceAadAdminInfoOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkspaceAadAdminInfo,
        KeyName = "activeDirectory",
        SegmentName = "administrators",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkspaceAadAdminInfos {
  /**
   * Gets a workspace active directory admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceAadAdmins_Get")
  get is WorkspaceAadAdminInfoOps.Read<WorkspaceAadAdminInfo>;

  /**
   * Creates or updates a workspace active directory admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WorkspaceAadAdmins_CreateOrUpdate")
  createOrUpdate is WorkspaceAadAdminInfoOps.CreateOrUpdateAsync<
    WorkspaceAadAdminInfo,
    Response =
      | ArmResourceUpdatedResponse<WorkspaceAadAdminInfo>
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: WorkspaceAadAdminInfo;
        }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a workspace active directory admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceAadAdmins_Delete")
  delete is WorkspaceAadAdminInfoOps.DeleteWithoutOkAsync<
    WorkspaceAadAdminInfo,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;
}
@armResourceOperations
interface WorkspaceSqlAadAdminOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkspaceAadAdminInfo,
        KeyName = "activeDirectory",
        SegmentName = "sqlAdministrators",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkspaceSqlAadAdmins {
  /**
   * Gets a workspace SQL active directory admin
   */
  get is WorkspaceSqlAadAdminOps.Read<WorkspaceAadAdminInfo>;

  /**
   * Creates or updates a workspace SQL active directory admin
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is WorkspaceSqlAadAdminOps.CreateOrUpdateAsync<
    WorkspaceAadAdminInfo,
    Response =
      | ArmResourceUpdatedResponse<WorkspaceAadAdminInfo>
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: WorkspaceAadAdminInfo;
        }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a workspace SQL active directory admin
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is WorkspaceSqlAadAdminOps.DeleteWithoutOkAsync<
    WorkspaceAadAdminInfo,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;
}

@@doc(WorkspaceAadAdminInfo.name, "");
@@doc(
  WorkspaceAadAdminInfo.properties,
  "Workspace active directory administrator properties"
);
@@doc(
  WorkspaceAadAdminInfos.createOrUpdate::parameters.resource,
  "Workspace active directory administrator properties"
);
@@doc(
  WorkspaceSqlAadAdmins.createOrUpdate::parameters.resource,
  "Workspace active directory administrator properties"
);
