import base64


def base64ToString(b):
    return base64.b64decode(b).decode('utf-8')
