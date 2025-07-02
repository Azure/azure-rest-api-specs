import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceGuardResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
// FIXME: DppBaseResource has no properties property
/**
 * Base resource under Microsoft.DataProtection provider namespace
 */
@parentResource(ResourceGuardResource)
model DppBaseResource is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DppBaseResource,
    KeyName = "requestName",
    SegmentName = "disableSoftDeleteRequests",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DppBaseResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "disableSoftDeleteRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResources {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultDisableSoftDeleteRequestsObject")
  getDefaultDisableSoftDeleteRequestsObject is DppBaseResourceOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDisableSoftDeleteRequestsObjects")
  getDisableSoftDeleteRequestsObjects is DppBaseResourceOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}
@armResourceOperations
interface ResourceGuardOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "deleteResourceGuardProxyRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ResourceGuards {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  getDefaultDeleteResourceGuardProxyRequestsObject is ResourceGuardOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  getDeleteResourceGuardProxyRequestsObjects is ResourceGuardOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}
@armResourceOperations
interface DppBaseResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "getBackupSecurityPINRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceOperationGroup {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultBackupSecurityPINRequestsObject")
  getDefaultBackupSecurityPINRequestsObject is DppBaseResourceOperationGroupOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetBackupSecurityPINRequestsObjects")
  getBackupSecurityPINRequestsObjects is DppBaseResourceOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}
@armResourceOperations
interface DppBaseResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "deleteProtectedItemRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceOperationGroup {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultDeleteProtectedItemRequestsObject")
  getDefaultDeleteProtectedItemRequestsObject is DppBaseResourceOperationGroupOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDeleteProtectedItemRequestsObjects")
  getDeleteProtectedItemRequestsObjects is DppBaseResourceOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}
@armResourceOperations
interface DppBaseResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "updateProtectionPolicyRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceOperationGroup {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultUpdateProtectionPolicyRequestsObject")
  getDefaultUpdateProtectionPolicyRequestsObject is DppBaseResourceOperationGroupOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetUpdateProtectionPolicyRequestsObjects")
  getUpdateProtectionPolicyRequestsObjects is DppBaseResourceOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}
@armResourceOperations
interface DppBaseResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ResourceGuardResource,
          KeyName = "resourceGuardsName",
          SegmentName = "resourceGuards",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DppBaseResource,
        KeyName = "requestName",
        SegmentName = "updateProtectedItemRequests",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DppBaseResourceOperationGroup {
  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetDefaultUpdateProtectedItemRequestsObject")
  getDefaultUpdateProtectedItemRequestsObject is DppBaseResourceOperationGroupOps.Read<DppBaseResource>;

  /**
   * Returns collection of operation request objects for a critical operation protected by the given ResourceGuard resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuards_GetUpdateProtectedItemRequestsObjects")
  getUpdateProtectedItemRequestsObjects is DppBaseResourceOperationGroupOps.List<
    DppBaseResource,
    Response = ArmResponse<DppBaseResourceList>
  >;
}

@@doc(DppBaseResource.name, "");
