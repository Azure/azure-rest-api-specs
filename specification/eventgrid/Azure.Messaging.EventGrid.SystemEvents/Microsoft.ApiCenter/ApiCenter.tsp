/** Describes the schema of the Azure API Center events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionAdded event. */
model ApiCenterApiDefinitionAddedEventData{

    /** API definition title. */
    title: string;

    /** API definition description. */
    description: string;

    /** API definition specification. */
    specification: ApiCenterApiSpecification;
}

/** Schema of the data property of an EventGridEvent for a Microsoft.ApiCenter.ApiDefinitionUpdated event. */
model ApiCenterApiDefinitionUpdatedEventData {

    /** API definition title. */
    title: string;

    /** API definition description. */
    description: string;

    /** API definition specification. */
    specification: ApiCenterApiSpecification;
}

/** API specification details. */
model ApiCenterApiSpecification {

    /** Specification name. */
    name: string;

    /** Specification version. */
    version: string;
}