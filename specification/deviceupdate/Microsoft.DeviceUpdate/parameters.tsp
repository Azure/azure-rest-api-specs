import "@typespec/http";

using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

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

/** Update provider parameter */
model UpdateProviderParameter {
  /** Update provider */
  @path
  provider: string;
}

/** Update name parameter. */
model UpdateNameParameter {
  /** Update name */
  @path
  name: string;
}

/** Update version parameter. */
model UpdateVersionParameter {
  /** Update version */
  @path
  version: string;
}
