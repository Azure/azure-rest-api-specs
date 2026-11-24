import "@azure-tools/typespec-azure-core";
import "./selector.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

/** Fleet-managed ambient application networking backed by an AppNet resource. */
@added(Versions.v2027_02_01_preview)
@parentResource(Fleet)
model AmbientProfile
  is Azure.ResourceManager.ProxyResource<AmbientProfileProperties> {
  ...ResourceNameParameter<
    AmbientProfile,
    KeyName = "ambientProfileName",
    SegmentName = "ambientProfiles",
    NamePattern = "^[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

/** Desired membership and service-owned state for an ambient profile. */
@added(Versions.v2027_02_01_preview)
model AmbientProfileProperties {
  /** The status of the last operation on the ambient profile. */
  @visibility(Lifecycle.Read)
  provisioningState?: AmbientProfileProvisioningState;

  /**
   * Select Fleet members using key/value label expressions with the `=` operator.
   * An omitted selector or an empty byLabel selects no members. PUT replaces the desired
   * selector; membership changes only when apply is called.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  memberSelector?: MemberSelector;

  /**
   * The service-owned backing AppNet resource ID. Its presence does not indicate successful
   * provisioning or membership apply. Customers cannot supply or replace the backing resource.
   */
  @visibility(Lifecycle.Read)
  appNetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppLink/appLinks";
    }
  ]>;

  /** The last operation details. This is not a continuous connectivity or health signal. */
  @visibility(Lifecycle.Read)
  status?: AmbientProfileStatus;
}

/** The provisioning state of the ambient profile resource. */
@added(Versions.v2027_02_01_preview)
@Azure.Core.lroStatus
union AmbientProfileProvisioningState {
  string,
  ResourceProvisioningState,

  /** The ambient profile is being applied to the selected Fleet members. */
  Applying: "Applying",
}

/** Service-owned details of the last operation on the ambient profile. */
@added(Versions.v2027_02_01_preview)
model AmbientProfileStatus {
  /** The last operation ID for the ambient profile. */
  @visibility(Lifecycle.Read)
  lastOperationId?: string;

  /** The customer-safe error from the last operation on the ambient profile. */
  @visibility(Lifecycle.Read)
  lastOperationError?: ErrorDetail;
}

/** Manage ambient profiles within a Fleet. */
@added(Versions.v2027_02_01_preview)
@armResourceOperations
interface AmbientProfiles {
  get is ArmResourceRead<AmbientProfile>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AmbientProfile,
    BaseParameters<AmbientProfile> &
      IfMatchParameters<AmbientProfile> &
      IfNoneMatchParameters<AmbientProfile>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AmbientProfile,
    BaseParameters<AmbientProfile> & IfMatchParameters<AmbientProfile>
  >;

  listByFleet is ArmResourceListByParent<AmbientProfile>;

  /** Apply the desired selector through AppNet and return the final ambient profile result. */
  apply is ArmResourceActionAsync<
    AmbientProfile,
    void,
    AmbientProfile,
    BaseParameters<AmbientProfile> & IfMatchParameters<AmbientProfile>
  >;
}
