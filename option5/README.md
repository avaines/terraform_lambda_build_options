# Option 3
Similar to option 2 though through use of s3_object and locals, terraform checks for the presence of the function code bundle with the appropriate name/tag/meta and invokes the packaging script if it doesn't exist.

![diagram](diagram.png)


## Requirements
| Requirement | Met |
| ------------|-----|
| Lambda function code should be versioned, promotable, and targetable  | :heavy_check_mark: |
| An environment should be able to use a specific code version | :heavy_check_mark: |
| The code a function is running should be identifiable and retrievable for analysis | :heavy_check_mark: |
| Code must be testable and tested | :heavy_check_mark: |
| Functions should not be replaced unless change has occured | :heavy_check_mark: |


### Cons
 - Potential for over engineering
 - Creative use of tagging objects to resolve the identification of package tags
 - Blurs the lines between TF as declarative and building packaging and the imperative task of versioning and bundling code 

### Pros
 - Automates some of the manual steps in seperation of the workflow
 - Medium complexity
 - Meets all of the requirements


### Notes
