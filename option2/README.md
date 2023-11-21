# Option 2
Entirely decoupled by having a script that manages the packaging of the Lambda

![diagram](diagram.png)


## Requirements
| Requirement | Met |
| ------------|-----|
| Lambda function code should be versioned, promotable, and targetable  | :heavy_check_mark: |
| An environment should be able to use a specific code version | :heavy_check_mark: |
| The code a function is running should be identifiable and retrievable for analysis | :heavy_check_mark: |
| Code must be testable and tested | :heavy_check_mark: |
| Functions should not be replaced unless change has occured | :wavy_dash: |


### Cons
 - Can be annoying to work with
 - Code packages must exist to perform a plan, may end up building a package before confirming an apply action resulting in non-confirmed code being uploaded
 - You would have to do this with a compiled language like C# or Java Lambdas realistically
 - Potential for over engineering
 - Creative use of tagging objects to resolve the identification of package tags
 - If the packaging of the function fails for some reason, an older code package could be used instead

### Pros
 - TF is declarative and building packaging and versioning of code should be imperative in nature
 - Medium complexity
 - Meets most of the requirements


### Notes
 - Simple obvious and clear
