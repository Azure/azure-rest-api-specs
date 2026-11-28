import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * Dedicated Sql Minimal Tls Settings Info
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Published definition name; renaming would change the OpenAPI definition and SDK type name."
model DedicatedSQLminimalTlsSettings
  is Azure.ResourceManager.ProxyResource<DedicatedSQLminimalTlsSettingsProperties> {
  ...ResourceNameParameter<
    Resource = DedicatedSQLminimalTlsSettings,
    KeyName = "dedicatedSQLminimalTlsSettingsName",
    SegmentName = "dedicatedSQLminimalTlsSettings",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias DedicatedSQLminimalTlsSettingsReadOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** The name of the dedicated sql minimal tls settings. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Published path parameter name; renaming would change the URL template and SDK parameter name."
    @segment("dedicatedSQLminimalTlsSettings")
    @key
    @path
    dedicatedSQLminimalTlsSettingsName: string;
  }
>;

alias DedicatedSQLminimalTlsSettingsWriteOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** The name of the dedicated sql minimal tls settings. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Published path parameter name; renaming would change the URL template and SDK parameter name."
    @segment("dedicatedSQLminimalTlsSettings")
    @key
    @path
    dedicatedSQLminimalTlsSettingsName: DedicatedSQLMinimalTlsSettingsName;
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Published operation group name (operationId prefix); renaming would change the SDK operation group."
@armResourceOperations
interface WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings {
  /**
   * Get workspace managed sql server's minimal tls settings.
   */
  get is DedicatedSQLminimalTlsSettingsReadOps.Read<DedicatedSQLminimalTlsSettings>;

  /**
   * Update workspace managed sql server's minimal tls settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is DedicatedSQLminimalTlsSettingsWriteOps.CreateOrUpdateAsync<
    DedicatedSQLminimalTlsSettings,
    Response =
      | ArmResourceUpdatedResponse<DedicatedSQLminimalTlsSettings>
      | ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmLroLocationHeader<FinalResult = DedicatedSQLminimalTlsSettings> &
            Azure.Core.Foundations.RetryAfterHeader
        >,
    LroHeaders = ArmLroLocationHeader<FinalResult = DedicatedSQLminimalTlsSettings> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List workspace managed sql server's minimal tls settings.
   */
  list is DedicatedSQLminimalTlsSettingsWriteOps.List<
    DedicatedSQLminimalTlsSettings,
    Response = ArmResponse<DedicatedSQLminimalTlsSettingsListResult>
  >;
}

@@doc(
  DedicatedSQLminimalTlsSettings.name,
  "The name of the dedicated sql minimal tls settings."
);
@@doc(DedicatedSQLminimalTlsSettings.properties, "Resource properties.");
@@doc(
  WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings.update::parameters.resource,
  "minimal tls settings"
);
