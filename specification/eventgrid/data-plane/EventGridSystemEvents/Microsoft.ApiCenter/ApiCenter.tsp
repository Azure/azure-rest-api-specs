import "./ApiCenterExample.tsp";
/** Describes the schema of the Azure API Center events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionAdded event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(ApiCenterApiDefinitionAddedExample)
model ApiCenterApiDefinitionAddedEventData {
  /** API definition title. */
  title: string;

  /** API definition description. */
  description?: string;

  /** API definition specification. */
  specification?: ApiCenterApiSpecification;
}

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionUpdated event. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(ApiCenterApiDefinitionUpdatedExample)
model ApiCenterApiDefinitionUpdatedEventData {
  /** API definition title. */
  title: string;

  /** API definition description. */
  description?: string;

  /** API definition specification. */
  specification?: ApiCenterApiSpecification;
}

/** API specification details. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ApiCenterApiSpecification {
  /** Specification name. */
  name: string;

  /** Specification version. */
  version?: string;
}
