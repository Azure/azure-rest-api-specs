// Resource name scalars kept outside the service namespace so the autorest emitter
// writes their constraints directly into the path parameters that use them instead
// of emitting standalone definitions into every API version.
namespace AgentFabricResourceNames;

/** A resource name of 3 to 24 letters, digits, or hyphens. */
@pattern("^[a-zA-Z0-9-]{3,24}$")
scalar ResourceNameUpTo24Characters extends string;

/** A resource name of 3 to 256 letters, digits, or hyphens. */
@pattern("^[a-zA-Z0-9-]{3,256}$")
scalar ResourceName extends string;

// Same as ArmResourceCreatedResponse without @pollingLocation. That decorator's
// StatusMonitorPollingOptions<Resource> instance makes the versioning mutator re-register
// ClusterAssociation in API versions that predate it, where its versioned name property
// is absent, failing arm-resource-missing-name-property.
@doc("Resource '{name}' create operation succeeded", Resource)
model CreatedResponseWithoutPollingLocation<
  Resource extends {},
  LroHeaders extends TypeSpec.Reflection.Model
> {
  ...TypeSpec.Http.CreatedResponse;
  ...LroHeaders;

  /** The resource body */
  @TypeSpec.Http.bodyRoot
  body: Resource;
}
