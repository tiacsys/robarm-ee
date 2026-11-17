# Sphinx configuration of the board document "Canary Board" (pcba-canary-board), made by
# `curatrix new pcba` from xdmod/templates/kicad-pcba/doc/ (XD-ADR-0129). The shared XDMOD setup
# (xdmod/sphinx/xdmod_conf.py) wraps zdocs' configure() and loads the XDMOD Sphinx extension.
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(os.environ["ZDOCS_WEST_TOPDIR"]) / "xdmod" / "sphinx"))
from xdmod_conf import configure, repo_root  # noqa: E402

REPO = repo_root(__file__)
configure(globals(), __file__, "Canary Board",
          generated=[(REPO, "generated/*.json")])
