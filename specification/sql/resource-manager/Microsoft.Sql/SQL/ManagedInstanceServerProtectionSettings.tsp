import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./ManagedInstance.tsp";
import "./ServerProtectionSettingsFeatureRegistration.tsp";
import "./ServerProtectionSettingsModels.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/**
 * The singleton protection settings for a managed instance. The only supported
 * resource name is default. Enabling protection is an irreversible opt-in.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This SQL project uses legacy-feature-files output splitting; this resource belongs to the server protection settings feature."
@added(Versions.v2026_11_01_preview)
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.Features.ManagedInstanceServerProtectionSettings
)
model ManagedInstanceServerProtectionSettings is ProxyResource<
  ServerProtectionSettingsProperties,
  PropertiesOptional = false
> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceServerProtectionSettings,
    KeyName = "serverProtectionSettingsName",
    SegmentName = "serverProtectionSettings",
    NamePattern = "^[dD][eE][fF][aA][uU][lL][tT]$",
    Type = ServerProtectionSettingsName
  >;
}

/** The update is in progress. Follow the polling headers to retrieve its result. */
@added(Versions.v2026_11_01_preview)
model ManagedInstanceServerProtectionSettingsAcceptedResult {
  ...AcceptedResponse;
  ...ArmCombinedLroHeaders<FinalResult = ManagedInstanceServerProtectionSettings>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  /** Metadata for the accepted update. */
  @body body: ServerProtectionSettingsOperationMetadata;
}

/** Parent instance identifier for protection-settings operations. */
alias ServerProtectionSettingsRequestParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The provider namespace for the resource. */
  @path
  @segment("providers")
  provider: "Microsoft.Sql";

  /** The name of the managed instance. */
  @path
  @segment("managedInstances")
  @pattern("^[A-Za-z0-9]+(-*[A-Za-z0-9]+)*$")
  @minLength(1)
  @maxLength(63)
  managedInstanceName: string;
};

/** Path parameters for the protection-settings singleton. */
alias ServerProtectionSettingsInstanceParameters = {
  ...ServerProtectionSettingsRequestParameters;

  /** The protection settings name. Only default is supported. */
  @path
  @segment("serverProtectionSettings")
  @pattern("^[dD][eE][fF][aA][uU][lL][tT]$")
  serverProtectionSettingsName: ServerProtectionSettingsName;
};

/** Read, list, and update the default protection settings of a managed instance. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "These settings always exist with the managed instance and cannot be deleted; enabling protection is irreversible."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This SQL project requires legacy-feature-files output splitting for operation registration."
@added(Versions.v2026_11_01_preview)
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.Features.ManagedInstanceServerProtectionSettings
)
interface ManagedInstanceServerProtectionSettingsOperations {
  /** Gets a managed instance's server protection settings. */
  @get
  @autoRoute
  @tag("ManagedInstanceServerProtectionSettings")
  @armResourceRead(ManagedInstanceServerProtectionSettings)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    ServerProtectionSettingsInstanceParameters,
    ArmResponse<ManagedInstanceServerProtectionSettings>,
    ErrorResponse
  >;

  /**
   * Lists the managed instance's server protection settings. The collection contains the default resource.
   */
  @get
  @autoRoute
  @list
  @tag("ManagedInstanceServerProtectionSettings")
  @listsResource(ManagedInstanceServerProtectionSettings)
  @segmentOf(ManagedInstanceServerProtectionSettings)
  @armResourceList(ManagedInstanceServerProtectionSettings)
  listByManagedInstance is Azure.ResourceManager.Foundations.ArmReadOperation<
    ServerProtectionSettingsRequestParameters,
    ArmResponse<ResourceListResult<ManagedInstanceServerProtectionSettings>>,
    ErrorResponse
  >;

  /**
   * Updates managed instance server protection setting. Returns HTTP 202 with
   * operation metadata and polling headers while the update is in progress,
   * or HTTP 200 with the resource when the update has completed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This existing singleton returns 202 while updating and 200 on completion; PUT never creates a new resource."
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The SQL RP returns operation metadata for pending 202 responses and the resource only for completed 200 responses."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The SQL RP pending 202 response contains the operation name and start time."
  @put
  @autoRoute
  @tag("ManagedInstanceServerProtectionSettings")
  @armResourceCreateOrUpdate(ManagedInstanceServerProtectionSettings)
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ServerProtectionSettingsInstanceParameters,
    ManagedInstanceServerProtectionSettings,
    | ArmResponse<ManagedInstanceServerProtectionSettings>
    | ManagedInstanceServerProtectionSettingsAcceptedResult,
    ErrorResponse
  >;
}

@@doc(
  ManagedInstanceServerProtectionSettings.name,
  "The protection settings name. Only default is supported."
);
@@doc(
  ManagedInstanceServerProtectionSettings.properties,
  "The required managed instance protection settings."
);
@@doc(
  ManagedInstanceServerProtectionSettingsOperations.createOrUpdate::parameters.resource,
  "The managed instance protection settings to apply."
);
