# -*- coding: utf-8 -*-
#
# Configuration file for the Sphinx documentation builder.
#
# This file does only contain a selection of the most common options. For a
# full list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

import glob
import json
import os
import sys

# -- Project information -----------------------------------------------------

project = 'Flibcpp'
copyright = '2021, Oak Ridge National Laboratory, UT-Battelle, LLC'
author = 'Seth R Johnson'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
try:
    build_dir = os.environ['CMAKE_CURRENT_BINARY_DIR']
    with open(os.path.join(build_dir, 'version.json'), 'r') as f:
        vers_dat = json.load(f)
except (KeyError, IOError) as e:
    print("Failed to load version:", e)
    version = ''
    release = ''
else:
    version = vers_dat['version']
    release = vers_dat['release']

sys.path.insert(0, os.path.join(os.path.abspath('.'), "_python"))
import monkeysphinx

# -- General configuration ---------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
# needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.mathjax',
    'sphinx.ext.githubpages',
]

try:
    import pybtex
except ImportError:
    print("Can't import pybtex: bibliography will not be generated.")
    print("Download and install using `pip install sphinxcontrib-bibtex`")
else:
    extensions.append("sphinxcontrib.bibtex")
    bibtex_bibfiles = ['_static/references.bib']

# Add any paths that contain templates here, relative to this directory.
templates_path = []

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path .
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'
highlight_language = 'fortran'


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'alabaster'

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = []

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# The default sidebars (for documents that don't match any pattern) are
# defined by theme itself.  Builtin themes are using these templates by
# default: ``['localtoc.html', 'relations.html', 'sourcelink.html',
# 'searchbox.html']``.
#
# html_sidebars = {}


# -- Options for HTMLHelp output ---------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = 'Flibcpp'


# -- Options for LaTeX output ------------------------------------------------


latex_elements = {
# The paper size ('letterpaper' or 'a4paper').
'papersize': 'letterpaper',

'extraclassoptions': 'oneside',

# The font size ('10pt', '11pt' or '12pt').
'pointsize': '11pt',

# Additional stuff for the LaTeX preamble.
'preamble': r"""
% Reset styles changed by sphinx.sty
\usepackage{ornltm-style}
\usepackage{ornltm-extract}
\usepackage{sphinxcustom}
\usepackage{microtype}
\usepackage{pdfpages}
""",

# Table of contents
'tableofcontents': r"""
\frontmatter
% Plain page
\thispagestyle{plain}%
\phantomsection\addcontentsline{toc}{section}{Contents}
\tableofcontents
% %
% \cleardoublepage
% \thispagestyle{plain}%
% \phantomsection\addcontentsline{toc}{section}{List of Figures}
% \listoffigures
% %
% \cleardoublepage
% \thispagestyle{plain}%
% \phantomsection\addcontentsline{toc}{section}{List of Tables}
% \listoftables
% \cleardoublepage
% \pagestyle{normal}
""",
# No chapter styles needed
'fncychap': "",
# Make references more robust to renumbering
'hyperref': r"""
\usepackage[hypertexnames=false]{hyperref}
\usepackage{hypcap}
\urlstyle{same}
""",
# Replace maketitle with generated title page:
# see http://texdoc.net/texmf-dist/doc/latex/pdfpages/pdfpages.pdf
# and documents repo:
 'maketitle': r"\includepdf[pages=-]{flibcpp-tm-header.pdf}",
 'atendofbody': r"\includepdf[pages=-]{flibcpp-tm-footer.pdf}",
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (master_doc, 'Flibcpp.tex', 'Flibcpp User Manual',
     author, 'howto'),
]

latex_additional_files = glob.glob("_static/*.sty")

# -- Options for manual page output ------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'flibcpp', 'Flibcpp Documentation',
     [author], 1)
]


# -- Options for Texinfo output ----------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, 'Flibcpp', 'Flibcpp Documentation',
     author, 'Flibcpp', 'One line description of project.',
     'Miscellaneous'),
]


# -- Extension configuration -------------------------------------------------
