import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Container Registry events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftContainerRegistryImagePushedExample: ContainerRegistryImagePushedEventData = #{
  id: "c25fdb80-ebbd-4dd0-a29c-a7349e6388f6",
  timestamp: "2021-09-08T06:37:45.4681009Z",
  action: "push",
  location: "westus",
  target: #{
    mediaType: "application/vnd.docker.distribution.manifest.v2+json",
    size: 1153,
    digest: "sha256:57a94fc99816c6aa225678b738ac40d85422e75dbb96115f1bb9b6ed77176166",
    length: 1153,
    repository: "samples/nginx",
    tag: "latest",
  },
  request: #{
    id: "9f8fa9d4-5b86-4066-b805-e406f321c7d6",
    host: "jolovcr.azurecr.io",
    method: "PUT",
    useragent: "docker/20.10.7 go/go1.13.15 git-commit/b0f5bc3 kernel/5.10.16.3-microsoft-standard-WSL2 os/linux arch/amd64 UpstreamClient(Docker-Client/20.10.7 \\(windows\\))",
  },
  connectedRegistry: #{ name: "edge1" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerRegistry.ImagePushed event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftContainerRegistryImagePushedExample)
model ContainerRegistryImagePushedEventData
  extends ContainerRegistryEventData {}

const MicrosoftContainerRegistryImageDeletedExample: ContainerRegistryImageDeletedEventData = #{
  id: "6fdef14c-2594-41e8-9156-c0376eb0a190",
  timestamp: "2021-09-08T06:49:40.1850248Z",
  action: "delete",
  location: "westus",
  target: #{
    mediaType: "application/vnd.docker.distribution.manifest.v2+json",
    digest: "sha256:57a94fc99816c6aa225678b738ac40d85422e75dbb96115f1bb9b6ed77176166",
    repository: "samples/nginx",
  },
  request: #{
    id: "62a60cbd-1bfc-4742-b013-ed7098922ca6",
    host: "jolovcr.azurecr.io",
    method: "DELETE",
    useragent: "python-requests/2.22.0",
  },
  connectedRegistry: #{ name: "edge1" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerRegistry.ImageDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftContainerRegistryImageDeletedExample)
model ContainerRegistryImageDeletedEventData
  extends ContainerRegistryEventData {}

const MicrosoftContainerRegistryChartPushedExample: ContainerRegistryChartPushedEventData = #{
  id: "ea3a9c28-5b17-40f6-a500-3f02b682927",
  timestamp: utcDateTime.fromISO("2019-03-12T15:16:31.0087496-07:00"),
  action: "chart_push",
  location: "westus",
  target: #{
    mediaType: "application/vnd.acr.helm.chart",
    size: 25265,
    digest: "sha256:7f060075264b5ba7c14c23672698152ae6a3ebac1c47916e4efe19cd624d5fab",
    repository: "repo",
    tag: "mychart-1.0.0.tgz",
    name: "mychart",
    version: "1.0.0",
  },
  connectedRegistry: #{ name: "edge1" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerRegistry.ChartPushed event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftContainerRegistryChartPushedExample)
model ContainerRegistryChartPushedEventData
  extends ContainerRegistryArtifactEventData {}

const MicrosoftContainerRegistryChartDeletedExample: ContainerRegistryChartDeletedEventData = #{
  id: "ea3a9c28-5b17-40f6-a500-3f02b682927",
  timestamp: utcDateTime.fromISO("2019-03-12T15:42:08.3783775-07:00"),
  action: "chart_delete",
  location: "westus",
  target: #{
    mediaType: "application/vnd.acr.helm.chart",
    size: 25265,
    digest: "sha256:7f060075264b5ba7c14c23672698152ae6a3ebac1c47916e4efe19cd624d5fab",
    repository: "repo",
    tag: "mychart-1.0.0.tgz",
    name: "mychart",
    version: "1.0.0",
  },
  connectedRegistry: #{ name: "edge1" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerRegistry.ChartDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftContainerRegistryChartDeletedExample)
model ContainerRegistryChartDeletedEventData
  extends ContainerRegistryArtifactEventData {}

alias ContainerRegistryBaseEventData = {
  /** The event ID. */
  id: string;

  /** The time at which the event occurred. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  timestamp: utcDateTime;

  /** The action that encompasses the provided event. */
  action: string;

  /** The location of the event. */
  location: string;
};

/** The content of the event request message. */
model ContainerRegistryEventData {
  ...ContainerRegistryBaseEventData;

  /** The target of the event. */
  target: ContainerRegistryEventTarget;

  /** The request that generated the event. */
  request?: ContainerRegistryEventRequest;

  /** The agent that initiated the event. For most situations, this could be from the authorization context of the request. */
  actor: ContainerRegistryEventActor;

  /** The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it. */
  source: ContainerRegistryEventSource;

  /** The connected registry information if the event is generated by a connected registry. */
  connectedRegistry?: ContainerRegistryEventConnectedRegistry;
}

/** The content of the event request message. */
model ContainerRegistryArtifactEventData {
  ...ContainerRegistryBaseEventData;

  /** The target of the event. */
  target: ContainerRegistryArtifactEventTarget;

  /** The connected registry information if the event is generated by a connected registry. */
  connectedRegistry?: ContainerRegistryEventConnectedRegistry;
}

/** The target of the event. */
model ContainerRegistryEventTarget {
  /** The MIME type of the referenced object. */
  mediaType: string;

  /** The number of bytes of the content. Same as Length field. */
  size?: int64;

  /** The digest of the content, as defined by the Registry V2 HTTP API Specification. */
  digest?: string;

  /** The number of bytes of the content. Same as Size field. */
  length?: int64;

  /** The repository name. */
  repository: string;

  /** The direct URL to the content. */
  url?: string;

  /** The tag name. */
  tag?: string;
}

/** The target of the event. */
model ContainerRegistryArtifactEventTarget {
  ...ContainerRegistryBaseEventTarget<
    "The MIME type of the artifact.",
    "The size in bytes of the artifact.",
    "The digest of the artifact.",
    "The repository name of the artifact.",
    "The tag of the artifact."
  >;

  /** The name of the artifact. */
  name?: string;

  /** The version of the artifact. */
  version?: string;
}

/** The request that generated the event. */
model ContainerRegistryEventRequest {
  /** The ID of the request that initiated the event. */
  id: string;

  /** The IP or hostname and possibly port of the client connection that initiated the event. This is the RemoteAddr from the standard http request. */
  addr?: string;

  /** The externally accessible hostname of the registry instance, as specified by the http host header on incoming requests. */
  host: string;

  /** The request method that generated the event. */
  method: string;

  /** The user agent header of the request. */
  useragent?: string;
}

/** The agent that initiated the event. For most situations, this could be from the authorization context of the request. */
model ContainerRegistryEventActor {
  /** The subject or username associated with the request context that generated the event. */
  name?: string;
}

/** The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it. */
model ContainerRegistryEventSource {
  /** The IP or hostname and the port of the registry node that generated the event. Generally, this will be resolved by os.Hostname() along with the running port. */
  addr?: string;

  /** The running instance of an application. Changes after each restart. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after the existing service swagger."
  instanceID?: string;
}

/** The connected registry information if the event is generated by a connected registry. */
model ContainerRegistryEventConnectedRegistry {
  /** The name of the connected registry that generated this event. */
  name: string;
}

alias ContainerRegistryBaseEventTarget<
  TmediaType extends valueof string,
  Tsize extends valueof string,
  Tdigest extends valueof string,
  Trepository extends valueof string,
  Ttag extends valueof string
> = {
  @doc(TmediaType)
  mediaType: string;

  @doc(Tsize)
  size?: int64;

  @doc(Tdigest)
  digest?: string;

  @doc(Trepository)
  repository: string;

  @doc(Ttag)
  tag?: string;
};
