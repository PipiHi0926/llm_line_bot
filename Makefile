.PHONY: clean clean-build clean-pyc clean-test coverage docs help install lint test

.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os, webbrowser, sys
from urllib.request import pathname2url
webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys
for line in sys.stdin:
    match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
    if match:
        target, help = match.groups()
        print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

lint: lint/black ## check style with black
lint/black: ## check style with black
	black llm_line_bot tests

test: ## run tests quickly with the default Python
	pytest

coverage: ## check code coverage quickly with the default Python
	coverage run --source llm_line_bot -m pytest
	coverage report -m
	coverage html
	$(BROWSER) htmlcov/index.html

install: clean ## install the package to the active Python's site-packages # python setup.py install
	pip install . --upgrade --force-reinstall --user


patch: clean
	bump2version patch --verbose

minor: clean
	bump2version minor --verbose

major: clean
	bump2version major --verbose

release-patch: clean
	bump2version patch --verbose
	git push && git push --tags

release-minor: clean
	bump2version minor --verbose
	git push && git push --tags

release-major: clean
	bump2version major --verbose
	git push && git push --tags

release-tags: clean
	git push && git push --tags