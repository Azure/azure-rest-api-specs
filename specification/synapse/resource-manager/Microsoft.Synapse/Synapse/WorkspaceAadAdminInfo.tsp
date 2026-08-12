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

@armResourceOperations(WorkspaceAadAdminInfo)
interface WorkspaceAadAdminInfos {
  /**
   * Gets a workspace active directory admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceAadAdmins_Get")
  get is ArmResourceRead<WorkspaceAadAdminInfo>;

  /**
   * Creates or updates a workspace active directory admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WorkspaceAadAdmins_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
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
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkspaceAadAdminInfo,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;
}

/**
 * Workspace SQL active directory administrator
 */
@singleton("activeDirectory")
@parentResource(Workspace)
model WorkspaceSqlAadAdminInfo
  is Azure.ResourceManager.ProxyResource<AadAdminProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceSqlAadAdminInfo,
    KeyName = "sqlAdministrator",
    SegmentName = "sqlAdministrators",
    NamePattern = ""
  >;
}

@armResourceOperations(WorkspaceSqlAadAdminInfo)
interface WorkspaceSqlAadAdmins {
  /**
   * Gets a workspace SQL active directory admin
   */
  get is ArmResourceRead<WorkspaceSqlAadAdminInfo>;

  /**
   * Creates or updates a workspace SQL active directory admin
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkspaceSqlAadAdminInfo,
    Response =
      | ArmResourceUpdatedResponse<WorkspaceSqlAadAdminInfo>
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: WorkspaceSqlAadAdminInfo;
        }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a workspace SQL active directory admin
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkspaceSqlAadAdminInfo,
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
@@doc(WorkspaceSqlAadAdminInfo.name, "");
@@doc(
  WorkspaceSqlAadAdminInfo.properties,
  "Workspace SQL active directory administrator properties"
);
@@doc(
  WorkspaceAadAdminInfos.createOrUpdate::parameters.resource,
  "Workspace active directory administrator properties"
);
@@doc(
  WorkspaceSqlAadAdmins.createOrUpdate::parameters.resource,
  "Workspace active directory administrator properties"
);
