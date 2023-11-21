# Option 1
Manage both the function and its provisioning in Terraform using a local file deployment package

![diagram](diagram.png)


## Requirements
| Requirement | Met |
| ------------|-----|
| Lambda function code should be versioned, promotable, and targetable  | :x: |
| An environment should be able to use a specific code version | :heavy_check_mark: |
| The code a function is running should be identifiable and retrievable for analysis | :x: |
| Code must be testable and tested | :heavy_check_mark: |
| Functions should not be replaced unless change has occured | :x: |

### Cons
 - TF is declartive and building packaging and versioning of code should be imperative in nature
 - works fine for simple functions
 - Per tf docs, Terraform is not optimised for handling large file uploads and does NOT handle muli-part or chunkinor or even resuming uploads. This could lead to corrupted state
 - archive_file ONLY supports zip files, and as the shasum for the archive will change every time the archive is created, the function will be re-deployed.

    According to Wikipedia http://en.wikipedia.org/wiki/Zip_(file_format) seems that zip files have headers for File last modification time and File last modification date so any zip file created, even from the same files it will have a different checksum value. It seems that there is no flag to tell it to not set those headers.

### Pros
 - Low complexity
 - Follows terraform docs
 - Using a null_resource to pack a tarball instead of a zip could work around the shasum issue


### Notes
 - Simple obvious and clear
 - Ensures TF can build out it's dependency graph correctly so the function is bundled and the lambda resource can reference it
