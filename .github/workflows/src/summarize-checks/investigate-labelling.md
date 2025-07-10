# Needing "label" context when handling the listed labels


This is the original logic
```js
  if (event_name === "labeled") {
    if (changedLabel == "ARMChangesRequested") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToRemove.add("WaitForARMFeedback");
      }
    }
    if (changedLabel == "ARMSignedOff") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToRemove.add("WaitForARMFeedback");
      }
      if (known_labels.indexOf("ARMChangesRequested") !== -1) {
        labelsToRemove.add("ARMChangesRequested");
      }
    }
  } else if (event_name === "unlabeled") {
    if (changedLabel == "ARMChangesRequested") {
      if (known_labels.indexOf("WaitForARMFeedback") !== -1) {
        labelsToAdd.add("WaitForARMFeedback");
      }
    }
  }
```

So:

```
fn(event, changedLabel, knownLabels)

fn("labeled", "ArmChangesRequested", ["ARMChangesRequested", "WaitForARMFeedback"])
  -> labelsToAdd: [], labelsToRemove: ["WaitForarmFeedback"]

fn("unlabeled", "ARMChangesRequested", ["WaitForARMFeedback"])
  -> labelsToAdd: ["WaitForArmFeedback"], labelsToRemove: []
```

Can we replace this with straightforward results?


input ["ARMChangesRequested", "WaitForARMFeedback"] -> Remove WaitForArmFeedback
input [No ArmChangesRequested] -> Add WaitForArmFeedback

