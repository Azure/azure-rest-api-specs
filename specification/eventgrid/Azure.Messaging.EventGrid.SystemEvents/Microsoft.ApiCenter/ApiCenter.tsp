import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure API Center events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionAdded event. */
model ApiCenterApiDefinitionAddedEventData {
  /** API definition title. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  title: string;

  /** API definition description. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  description: string;

  /** API definition specification. */
  specification: ApiCenterApiSpecification;
}

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionUpdated event. */
model ApiCenterApiDefinitionUpdatedEventData {
  /** API definition title. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  title: string;

  /** API definition description. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  description: string;

  /** API definition specification. */
  specification: ApiCenterApiSpecification;
}

/** API specification details. */
model ApiCenterApiSpecification {
  /** Specification name. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  name: string;

  /** Specification version. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  version: string;
}
