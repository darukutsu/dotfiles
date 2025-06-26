#!/usr/bin/env python3

import html
import os
import re
import sys

# import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup

# def parse_text_content(element):
#    magic = """<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
#                        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" [
#                        <!ENTITY nbsp ' '>
#                        ]>"""  # You can define more entities here, if needed
#    root = ET.fromstring(magic + element)
#    text = ET.tostring(root, encoding="unicode", method="text")
#    text = html.unescape(text)
#    return text


def parse_text_content(element):
    soup = BeautifulSoup(element, "html.parser")
    text = soup.get_text()
    text = html.unescape(text)
    return text


def main():
    element = os.environ.get("QUTE_SELECTED_HTML")
    code_text = parse_text_content(element)
    # delimiter = sys.argv[1] if len(sys.argv) > 1 else "r'\n'"
    # code_text = re.sub("(\n)+", delimiter, code_text)
    code_text = code_text.replace("\n", "\u000a")
    # code_text = "search" + code_text
    with open(os.environ.get("QUTE_FIFO"), "w") as f:
        f.write("search {}\n".format(code_text))
        f.flush()


if __name__ == "__main__":
    main()
