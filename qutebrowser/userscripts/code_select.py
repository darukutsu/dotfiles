#!/usr/bin/env python3

# JS: [userscript:_qute_js:1323] Refused to apply inline style because it violates the following Content Security Policy directive: "style-src 'self' https://assets.braintreegateway.com https://*.paypal.com 'sha256-or0p3LaHetJ4FRq+flVORVFFNsOjQGWrDvX8Jf7ACWg=' 'sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=' 'sha256-JVRXyYPueLWdwGwY9m/7u4QlZ1xeQdqUj2t8OVIzZE4=' 'sha256-Oca9ZYU1dwNscIhdNV7tFBsr4oqagBhZx9/p4w8GOcg=' 'sha256-VZTcMoTEw3nbAHejvqlyyRm1Mdx+DVNgyKANjpWw0qg='". Either the 'unsafe-inline' keyword, a hash ('sha256-4IjBmK5Lspt03QosPr8CiLRZvDtNPbJobG9srTDEA/8='), or a nonce ('nonce-...') is required to enable inline execution.

import html
import os
import re
import sys

# import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup

try:
    import pyperclip
except ImportError:
    try:
        import pyclip as pyperclip
    except ImportError:
        PYPERCLIP = False
    else:
        PYPERCLIP = True
else:
    PYPERCLIP = True


# def parse_text_content(element):
#    # https://stackoverflow.com/a/35591507/15245191
#    magic = """<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
#                "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
#                <!ENTITY nbsp ' '>
#                ]>"""  # You can define more entities here, if needed
#    root = ET.fromstring(magic + element)
#    text = ET.tostring(root, encoding="unicode", method="text")
#    text = html.unescape(text)
#    return text


def parse_text_content(element):
    soup = BeautifulSoup(element, "html.parser")
    text = soup.get_text()
    text = html.unescape(text)
    return text


def send_command_to_qute(command):
    with open(os.environ.get("QUTE_FIFO"), "w") as f:
        f.write(command)


def main():
    delimiter = sys.argv[1] if len(sys.argv) > 1 else ";"
    # For info on qute environment variables, see
    # https://github.com/qutebrowser/qutebrowser/blob/master/doc/userscripts.asciidoc
    element = os.environ.get("QUTE_SELECTED_HTML")
    code_text = parse_text_content(element)
    re_remove_dollars = re.compile(r"^(\$ )", re.MULTILINE)
    code_text = re.sub(re_remove_dollars, "", code_text)
    if PYPERCLIP:
        pyperclip.copy(code_text)
        send_command_to_qute(
            "message-info 'copied to clipboard: {info}{suffix}'".format(
                info=code_text.splitlines()[0].replace("'", '"'),
                suffix="..." if len(code_text.splitlines()) > 1 else "",
            )
        )
    else:
        # Qute's yank command  won't copy across multiple lines so we
        # compromise by placing lines on a single line separated by the
        # specified delimiter
        code_text = re.sub("(\n)+", delimiter, code_text)
        code_text = code_text.replace("'", '"')
        send_command_to_qute("yank inline '{code}'\n".format(code=code_text))


if __name__ == "__main__":
    main()
