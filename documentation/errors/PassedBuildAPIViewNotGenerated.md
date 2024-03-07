## APIView Failures: troubleshooting guides

### Passed build but APIView not generated

- Check for an unexpected skip of `Publish SDK APIView Artifact to Pipeline Artifacts` and `Generate SDK APIView` step.
- Look in `SDK Automation` step to verify that the API token generation completed successfully.
- Search logs for `Read Temp File`
- Find the .json object object below and search for the `apiViewArtifact` property.
- If not present, the APIView parser for the language failed to generate the `APIView Token Artifacts`.
- Further investigate by running the package through the appropriate language parser locally: [here](https://github.com/Azure/azure-sdk-tools/tree/main/tools/apiview)  or  [here](https://github.com/Azure/azure-sdk-tools/tree/main/src)