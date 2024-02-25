import sys

def lambda_handler(event,context):
    return f"Helo World, {sys.version}!"


if __name__ == "__main__":
    lambda_handler("", "")
