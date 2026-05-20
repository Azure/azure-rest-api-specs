import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RedHatOpenShift;
/**
 * OpenShiftVersion represents an OpenShift version that can be installed.
 */
@subscriptionResource
model OpenShiftVersion
  is Azure.ResourceManager.ProxyResource<OpenShiftVersionProperties> {
  ...ResourceNameParameter<
    Resource = OpenShiftVersion,
    KeyName = "openShiftVersion",
    SegmentName = "openShiftVersions",
    NamePattern = "^(\\d+)\\.(\\d+)\\.(\\d+)(.*)"
  >;
}

alias OpenShiftVersionsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
    ...LocationResourceParameter;
  },
  {
    /** The desired version value of the OpenShiftVersion resource. */
    @path
    @segment("openShiftVersions")
    @key
    @pattern("^(\\d+)\\.(\\d+)\\.(\\d+)(.*)")
    @minLength(1)
    @maxLength(63)
    openShiftVersion: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface OpenShiftVersions {
  /**
   * This operation returns installable OpenShift version as a string.
   */
  @summary("Gets an available OpenShift version to install in the specified location.")
  get is OpenShiftVersionsOps.Read<OpenShiftVersion>;

  /**
   * The operation returns the installable OpenShift versions as a string.
   */
  @summary("Lists all OpenShift versions available to install in the specified location.")
  list is OpenShiftVersionsOps.List<
    OpenShiftVersion,
    Response = ArmResponse<OpenShiftVersionList>
  >;
}

@@maxLength(OpenShiftVersion.name, 63);
@@minLength(OpenShiftVersion.name, 1);
@@doc(OpenShiftVersion.name,
  "The desired version value of the OpenShiftVersion resource."
);
@@doc(OpenShiftVersion.properties,
  "The properties for the OpenShiftVersion resource."
);
