#!/usr/bin/env python

"""The setup script."""

from setuptools import find_packages, setup

setup(
    name='llm_line_bot',
    packages=find_packages(
        include=['llm_line_bot', 'llm_line_bot.*']
    ),
    test_suite='tests',
    version="0.1.0",
)
