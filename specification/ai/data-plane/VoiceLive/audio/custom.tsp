import "./models.tsp";

union TranscriptTextUsageType {
  tokens: "tokens",
  duration: "duration",
}

@discriminator("type")
model TranscriptTextUsage {
  type: TranscriptTextUsageType;
}
