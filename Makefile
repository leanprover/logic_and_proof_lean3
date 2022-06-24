# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = python -msphinx
SPHINXPROJ    = logic_and_proof
SOURCEDIR     = .
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

VENVDIR := .venv
export PATH := $(VENVDIR)/bin:$(PATH)

install-deps:
	test -f $(VENVDIR)/bin/pip || python3 -m venv $(VENVDIR)
	pip install pygments
	pip install 'wheel>=0.29' # needed for old ubuntu versions, https://github.com/pallets/markupsafe/issues/59
	pip install sphinx
.PHONY: help Makefile

images:
	cd latex_images && make copy_images

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

