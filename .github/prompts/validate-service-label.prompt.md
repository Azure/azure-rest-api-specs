---
mode: 'agent'
tools: ['CheckServiceLabel', 'CreateServiceLabel']
---
 
## Goal
Validate that a service label exists for the corresponding SDK and create a new service label with pull request if necessary to support the SDK release process.
 
---
 
## Step 1: Collect Service Label Information
- Ask user if they have a service label for their service
- If a label is provided:
  - Record the service label for validation in Step 2
  - Proceed to **Step 2: Validate Service Label**
- If no label is provided:
  - Inform user that a service label is required for SDK release process
  - Proceed to **Step 2: Validate Service Label** (will handle creation process)
 
## Step 2: Validate Service Label
Use `CheckServiceLabel` tool to verify the service label status in the azure-sdk-tools repository.
 
### Handle Validation Results:

#### If the service label **Exists**:
- Display success message: "Service label '[label-name]' is valid and exists in common-labels.csv"
- **VALIDATION PASSED**: User can proceed with the SDK release process
- End validation process
 
#### If the service label **InReview**:
- Inform the user: "Service label '[label-name]' is currently waiting for pull request approval"
- Display the pull request information if available
- User can proceed with SDK release process (label will be available once PR is merged)
- End validation process
 
#### If the service label **DoesNotExist**:
- Inform the user that the service label doesn't exist in common-labels.csv
- Proceed to **Step 3: Service Label Creation Process**
 
#### If the service label **NotAServiceLabel**:
- Inform the user that the label exists but is not a 'service' label (wrong color code)
- Explain that only labels with color code "e99695" are valid service labels
- Proceed to **Step 3: Service Label Creation Process** to create a new service label
 
---
 
## Step 3: Service Label Creation Process
When no valid service label exists, guide the user through creating a new one.
 
### Step 3A: Check for Existing Related Labels
- Search common-labels.csv file from the azure-sdk-tools repository for existing labels that could be related to the user's service
- If related service labels are found:
  - Present the related labels to the user
  - Ask: "Would you like to use one of these existing service labels instead of creating a new one?"
  - If user confirms an existing label → Return to **Step 2** to validate the chosen label
  - If user wants to create new label → Proceed to **Step 3B**
 
### Step 3B: Generate Service Label Recommendation
- Analyze the service's API specification to suggest an appropriate label name
- Apply service label naming guidelines:
  - **Exclude Microsoft/Azure**: Label text should not include "Microsoft" or "Azure"
  - **Title Case**: Capitalize first letter of each word, except short prepositions (in, for, of) unless first/last word
  - **Avoid Service Groups**: Use "Communication Rooms" instead of "Communication - Rooms"
  - **Single Label Per Service**: Create one label per service unless different teams manage sub-services
  - **Maintain Alphabetical Order**: New label will be inserted to maintain file organization
- Present recommended label name to user for confirmation
 
### Step 3C: User Confirmation
- Display the recommended service label name
- Ask user to confirm or suggest modifications
- Once confirmed, record the final service label name
 
### Step 3D: Add Service Label and Create Pull Request
Use `CreateServiceLabel` tool to create the new service label with:
- **label**: the confirmed service label name
- **link**: link to documentation or relevant resource for the service provided by the user
 
#### Pull Request Handling:
- If branch already exists: Provide compare link to review existing changes
- If new branch created: Provide link to the new pull request
- Display pull request information including:
  - Branch name
  - Pull request URL
  - Service label details
 
---
 
## Step 4: Completion
### For Existing Valid Labels:
- Display final service label information
- User can proceed immediately with SDK release
 
### For New Label Creation:
- Display pull request creation results
- Provide pull request link for review and merging
- Inform user: "You can proceed with the SDK release process once the pull request is approved and merged to main branch"
- Show next steps for monitoring PR approval status

---
 
## Error Handling
- If `CheckServiceLabel` fails: Ask user to verify service label spelling, punctuation, space usage, etc. and try again