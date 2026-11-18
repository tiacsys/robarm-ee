# Sphinx configuration of the document "Harnesses" (harnesses): every cable of robarm-ee in one
# document (tiacsys/xdmod#69 finding 15, XD-ADR-0149). The shared XDMOD setup
# (xdmod/sphinx/xdmod_conf.py) wraps zdocs' configure() and loads the XDMOD Sphinx extension with
# the harness directives.
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(os.environ["ZDOCS_WEST_TOPDIR"]) / "xdmod" / "sphinx"))
from xdmod_conf import configure, repo_root  # noqa: E402

REPO = repo_root(__file__)
configure(globals(), __file__, "Harnesses")
