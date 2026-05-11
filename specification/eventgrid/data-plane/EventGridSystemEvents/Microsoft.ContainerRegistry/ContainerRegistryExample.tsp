import "./ContainerRegistry.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftContainerRegistryImagePushedExample: ContainerRegistryImagePushedEventData = #{
  id: "c25fdb80-ebbd-4dd0-a29c-a7349e6388f6",
  timestamp: utcDateTime.fromISO("2021-09-08T06:37:45.4681009Z"),
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

const MicrosoftContainerRegistryImageDeletedExample: ContainerRegistryImageDeletedEventData = #{
  id: "6fdef14c-2594-41e8-9156-c0376eb0a190",
  timestamp: utcDateTime.fromISO("2021-09-08T06:49:40.1850248Z"),
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
    tag: "my-chart-1.0.0.tgz",
    name: "my-chart",
    version: "1.0.0",
  },
  connectedRegistry: #{ name: "edge1" },
};

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
    tag: "my-chart-1.0.0.tgz",
    name: "my-chart",
    version: "1.0.0",
  },
  connectedRegistry: #{ name: "edge1" },
};
