import "./AppConfiguration.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftAppConfigurationKeyValueModifiedExample: AppConfigurationKeyValueModifiedEventData = #{
  key: "Foo",
  label: "FizzBuzz",
  etag: "FnUExLaj2moIi4tJX9AXn9sakm0",
  syncToken: "zAJw6V16=Njo1IzUxNjQ2NzM=;sn=5164673",
};

const MicrosoftAppConfigurationKeyValueDeletedExample: AppConfigurationKeyValueDeletedEventData = #{
  key: "Foo",
  label: "FizzBuzz",
  etag: "FnUExLaj2moIi4tJX9AXn9sakm0",
  syncToken: "zAJw6V16=Njo1IzUxNjQ2NzM=;sn=5164673",
};

const MicrosoftAppConfigurationSnapshotCreatedExample: AppConfigurationSnapshotCreatedEventData = #{
  name: "Foo",
  etag: "FnUExLaj2moIi4tJX9AXn9sakm0",
  syncToken: "zAJw6V16=Njo1IzUxNjQ2NzM=;sn=5164673",
};

const MicrosoftAppConfigurationSnapshotModifiedExample: AppConfigurationSnapshotModifiedEventData = #{
  name: "Foo",
  etag: "FnUExLaj2moIi4tJX9AXn9sakm0",
  syncToken: "zAJw6V16=Njo1IzUxNjQ2NzM=;sn=5164673",
};
