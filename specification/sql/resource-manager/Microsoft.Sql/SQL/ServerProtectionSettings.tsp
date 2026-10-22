import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Server.tsp";
import "./ServerProtectionSettingsFeatureRegistration.tsp";
import "./ServerProtectionSettingsModels.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/** The protection settings that always exist for a logical server under the name default. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "SQL uses legacy feature files to split its OpenAPI output."
@added(Versions.v2026_11_01_preview)
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.Features.ServerProtectionSettings
)
model ServerProtectionSettings is ProxyResource<
  ServerProtectionSettingsProperties,
  PropertiesOptional = false
> {
  ...ResourceNameParameter<
    Resource = ServerProtectionSettings,
    KeyName = "serverProtectionSettingsName",
    SegmentName = "serverProtectionSettings",
    NamePattern = "^[dD][eE][fF][aA][uU][lL][tT]$",
    Type = ServerProtectionSettingsName
  >;
}

/** The update is in progress. Follow the polling headers to retrieve its result. */
@added(Versions.v2026_11_01_preview)
model ServerProtectionSettingsAcceptedResult {
  ...AcceptedResponse;
  ...ArmCombinedLroHeaders<FinalResult = ServerProtectionSettings>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  /** Metadata for the accepted update. */
  @body body: ServerProtectionSettingsOperationMetadata;
}

/** Parent logical server identifier for protection-settings operations. */
alias LogicalServerProtectionSettingsRequestParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The provider namespace for the resource. */
  @path
  @segment("providers")
  provider: "Microsoft.Sql";

  /** The name of the server. */
  @path
  @segment("servers")
  @pattern("^[a-z0-9]+(-*[a-z0-9]+)*$")
  @minLength(1)
  @maxLength(63)
  serverName: string;
};

/** Path parameters for the logical server protection-settings singleton. */
alias LogicalServerProtectionSettingsInstanceParameters = {
  ...LogicalServerProtectionSettingsRequestParameters;

  /** The protection settings name. Only default is supported. */
  @path
  @segment("serverProtectionSettings")
  @pattern("^[dD][eE][fF][aA][uU][lL][tT]$")
  serverProtectionSettingsName: ServerProtectionSettingsName;
};

/** Read, list, and update the default logical server protection settings. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The settings always exist with the logical server; irreversible protection cannot be removed by deleting the settings."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "SQL uses legacy feature files to register operations."
@added(Versions.v2026_11_01_preview)
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.Features.ServerProtectionSettings
)
interface ServerProtectionSettingsOperations {
  /** Gets the logical server's persisted protection settings, independently of pending updates. */
  @get
  @autoRoute
  @tag("ServerProtectionSettings")
  @armResourceRead(ServerProtectionSettings)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    LogicalServerProtectionSettingsInstanceParameters,
    ArmResponse<ServerProtectionSettings>,
    ErrorResponse
  >;

  /** Lists the logical server's persisted protection settings. The collection contains the default resource. */
  @get
  @autoRoute
  @list
  @tag("ServerProtectionSettings")
  @listsResource(ServerProtectionSettings)
  @segmentOf(ServerProtectionSettings)
  @armResourceList(ServerProtectionSettings)
  listByServer is Azure.ResourceManager.Foundations.ArmReadOperation<
    LogicalServerProtectionSettingsRequestParameters,
    ArmResponse<ResourceListResult<ServerProtectionSettings>>,
    ErrorResponse
  >;

  /**
   * Updates logical server protection settings. Returns HTTP 200 with the resource
   * if the update has completed, or HTTP 202 with operation metadata and polling
   * headers while it is pending. The same response contract applies to repeated
   * values. Follow
   * Azure-AsyncOperation for operation status: HTTP 200 with status InProgress,
   * Succeeded, Failed, or Canceled and error details on failure. The Location
   * endpoint returns HTTP 202 while pending, HTTP 200 with the complete settings
   * resource on success, or an appropriate HTTP error with the standard error
   * body on failure. Resource GET and LIST return HTTP 200 with the persisted
   * flag while the operation is pending. Requests to disable protection after opt-in are
   * rejected. This proxy resource does not expose provisioningState; update status
   * is available only through the operation polling endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This existing singleton returns 202 while updating and 200 on completion; PUT never creates a new resource."
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The SQL RP returns operation metadata for pending 202 responses and the resource only for completed 200 responses, following the MI contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The SQL RP pending 202 response contains the operation name and start time, following the MI contract."
  @tag("ServerProtectionSettings")
  @put
  @autoRoute
  @armResourceCreateOrUpdate(ServerProtectionSettings)
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    LogicalServerProtectionSettingsInstanceParameters,
    ServerProtectionSettings,
    | ArmResponse<ServerProtectionSettings>
    | ServerProtectionSettingsAcceptedResult,
    ErrorResponse
  >;
}

@@doc(
  ServerProtectionSettings.name,
  "The protection settings name. Only default is supported."
);
@@doc(
  ServerProtectionSettings.properties,
  "The required logical server protection settings."
);
@@doc(
  ServerProtectionSettingsOperations.createOrUpdate::parameters.resource,
  "The logical server protection settings to apply."
);
