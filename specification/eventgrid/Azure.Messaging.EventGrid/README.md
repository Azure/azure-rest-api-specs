# How To Run

There are three folders within Azure.Messaging.EventGrid that are important: `2018-01-01` (GA version), `2023-06-01-preview` (preview version), `SystemEvents` (the system events in typespec).


To generate the GA version of EventGrid from TypeSpec:

With `2018-01-01` as your root directory:

    `tsp compile client.tsp --emit YOUR_EMITTER`


To generate the beta version of EventGrid from TypeSpec:

With `2023-06-01-preview` as your root directory:

    `tsp compile client.tsp --emit YOUR_EMITTER`