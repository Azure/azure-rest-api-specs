import "@typespec/http";

using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;

/** If-None-Match conditional request parameter */
model IfNoneMatchParameter {
  /**
   * Defines the If-None-Match condition. The operation will be performed only if
   * the ETag on the server does not match this value.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Standard http header."
  @header
  `if-none-match`?: string;
}

/** The Device Update for IoT Hub account instance identifier. */
model InstanceIdParameter {

  /** The Device Update for IoT Hub account instance identifier. */
  @path
  instanceId: string
}

/** Update provider parameter */
model UpdateProviderParameter
{
  ...InstanceIdParameter,

  /** Update provider */
  @path
  provider: string
}

/** Update name parameter. */
model UpdateNameParameter
{
  ...UpdateProviderParameter,

  /** Update name */
  @path
  name: string
}

/** Update version parameter. */
model UpdateVersionParameter
{
  ...UpdateNameParameter,

  /** Update version */
  @path
  version: string
}