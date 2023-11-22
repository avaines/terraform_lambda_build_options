# Option 3
Similar to option 2 though through use of s3_object and locals, terraform checks for the presence of the function code bundle with the appropriate name/tag/meta and invokes the packaging script if it doesn't exist.

![diagram](diagram.png)

Whilst this is the next obvious step from Option 2 to achieve an automated approach without the issues inherent in using the archive_file resource, Terraform doesn't really provide "If not exist create it" operations in this way. It's an imperative rather than declarative approach, so now what Terraform was designed for, this can be worked around by doing something like getting the objects in the bucket that matches the one we want, if one exists then great, reference it with a s3_object data resource. But if it's missing run the script to create the package and upload it.

The problem with that is the null resource required to create the object only works on an apply, so your plans would fail till the object exists

Theres a better explanation of why this doesn't work here: https://discuss.hashicorp.com/t/create-terraform-resource-s3-bucket-object-if-already-doesnt-exists/24247
